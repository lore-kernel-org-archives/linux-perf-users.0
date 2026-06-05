Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A073B42DA
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692569; cv=none; b=sJP3dLcJvmt6IWmAEduWfNvMsy/o7jQ8qI6qfgUoPhT+tPYdFJyyjUkOHWSdCG0I7VsiSCEnPbp8IOpFbVJ5mTLa7ydZaL8DPYMSbbElSn55p1qkgdoq6Q78YDiQr3aVFhILDMdzZ0+4DMcGM6nVXTadeQAPzGEHiH1z/uv+7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692569; c=relaxed/simple;
	bh=VsrZbs89vjV0hwMc/o6cVXgN3CHJiW954eXHY3Ah1Zc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6IKYAhJGmS4jByQh7KOrbAKX9arm3cDNlQ+FEfgyfN8XKSXW60EWcqI4xjJUIXPDllIz5mcXXPR2tGIrKhoaMZyd4zJlrQHtAvF/JkZMc03W/TezFENSxK/NDNJZFdcBR8zM/oAPTQg79P91JrOnxyznpBJfGvykZRl8YcBItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyvskqj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyvskqj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD8B1F00893;
	Fri,  5 Jun 2026 20:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780692568;
	bh=/lVH9VsvEanf35xJHJUasyQLOQ1WIWdkGeX954KQ7IA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iyvskqj1hZ0wDkYILVACgRBjZPP9mjXMUing6C7EIBvYGbhBI3rhBEs2/wlQnWFdG
	 l5Gx9OuzfA9iyZoEAmASENQXs2juV6SBcDoRfpPcfyYN+crtL3eNtdkLiZ0GNTWTqy
	 EFQeZXZFlVcuQAVjFScaoB1nTn2eFh7DyIRWpJpN8hrFbYn1JHyEgvPVkEBWy/bxiv
	 jhNocK25lTZAsaBPA7eFYWAEfqhwSBGU885A3kh1BVFr/cRpyP/B6YbdeKoK01wR1S
	 PO2xVDhL5KCopkfc8w6U4aOE3Jbo9SJGbSQFcjEd8BkrBfBWWwqM6DkWVmo3qRMvjS
	 tyI202pFu3OTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] perf sched: Use thread__put() in
 free_idle_threads()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605203316.1758661-8-acme@kernel.org>
References: <20260605203316.1758661-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 20:49:27 +0000
Message-Id: <20260605204928.0BD8B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing thread__delete() with thread__put() fails to free idle t=
hreads when --idle-hist is enabled.
--

commit d621fd9eeb37b143f0b8551620d0ca4488e1be89
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Use thread__put() in free_idle_threads()

This commit changes the cleanup of idle threads from thread__delete() to
thread__put() to correctly balance reference counts. It aims to avoid
leaking pointer handles in REFCNT_CHECKING builds by routing the object
destruction through the reference count wrapper.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index e2df69a624765..b5a7a944f5c8c 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2442,7 +2442,7 @@ static void free_idle_threads(void)
>  			if (itr)
>  				thread__put(itr->last_thread);
> =20
> -			thread__delete(idle);
> +			thread__put(idle);

[Severity: High]
Does this replace an intentional forceful deletion with a reference decreme=
nt
that causes a leak when the idle_hist option is enabled?

In timehist_get_thread(), an additional reference to the idle thread is
acquired if sched->idle_hist is enabled:

tools/perf/builtin-sched.c:timehist_get_thread() {
    ...
		if (sched->idle_hist) {
			struct thread *idle;
			struct idle_thread_runtime *itr;

			idle =3D get_idle_thread(sample->cpu);
			if (idle =3D=3D NULL) {
    ...
			thread__put(itr->last_thread);
			itr->last_thread =3D thread__get(thread);
    ...
}

The reference acquired by get_idle_thread() is never released with a matchi=
ng
thread__put() before the function returns.

Previously, thread__delete() forcefully destroyed the thread object
regardless of this inflated reference count.

Now that the cleanup relies on thread__put() and the reference count reachi=
ng
zero, the leaked reference from timehist_get_thread() prevents the thread
object from being freed.

Does this result in permanently leaking the idle thread objects, their
private idle_thread_runtime data, and accumulated callchains?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605203316.1758=
661-1-acme@kernel.org?part=3D7
