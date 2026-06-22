Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC6352029;
	Mon, 22 Jun 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117303; cv=none; b=TgeV0WaqLlBbszUq+iug0okLzxULgeGYMg+6ThlBzPhBfJfMLHDz8arjISp7YEn2LRFDJXVWOZ+mRDp50RhVEzVXdL9Zd/LlhwTT8yA0JozfE/xxMvIGqCWKHSQuR5VdsE/jmpDXupZFTbhCkY4PbxxfySGWq1rIh45m6Kgm4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117303; c=relaxed/simple;
	bh=WL0DqHprf03BiR6kYcbEI9cIPO25Jsw1dIArROkipHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eUa9XR75zJVxcKQA6cwLVtjUL/Zxj6PT+yJPbne3meQ3dKSeYpXhNZ+nmZm1E6s54AkDycKpodduB4HY/ndSfkWh8mnrhWIh5QCkFKilHLTY+YZbHzzV+qUOpBat8xo5isPzvcC4kodQsFY9v8NkPpcB9HDkSLbNUyRS3I0zzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksoi79Oa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksoi79Oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DDB1F00A3A;
	Mon, 22 Jun 2026 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782117302;
	bh=qiTRqMZV9vIEwn9JTOedh6hS7T0O4XnhoJZAworRYpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ksoi79OaFDGM61qKGj85c6zPF/fMOkZeJudRUhYdekhJ0aNPPgUBW9In1fbUb61Qa
	 PrSvcowBM9ZuoB9t5oIep/U+SuAc+ttHJrkRC9Q+VDnhVe/UxPShUVQwCq57mSWUWj
	 7goemdMoImoVL7cGcbMu+E8oQanDya6w/Ye2djwWtOpxXcnC8laM/VoVj4g8HkW7J0
	 N2goTqV2xX5kyoJA7EVp0Cyyu09yuw1L3Lqb3TpVvZ8DDpYKBqNSBjt41OKuPzSqp9
	 eMyPAqD4FgMy+y9BhBehma88/HbF03kZ4S/lgp/WfBF6siPyJ8XGh84N91VkrmF5or
	 Claess+5wilog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 22/22] TEST(do-not-upstream): fake qemu vendor JSON +
 mapfile entry for CounterIDMask path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260622-counter_delegation-v7-22-0ba2fd34614e@meta.com>
References: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
 <20260622-counter_delegation-v7-22-0ba2fd34614e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:35:01 +0000
Message-Id: <20260622083502.43DDB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit is explicitly marked as 'do-not-upstream' and introdu=
ces artificial test data into the perf tool's PMU events database.
--

commit 845c89532d7f6f6ae99c8ce7e80ef23f83afdd90
Author: Atish Patra <atishp@meta.com>

TEST(do-not-upstream): fake qemu vendor JSON + mapfile entry for CounterIDM=
ask path

This commit adds fake JSON events for qemu/virt to the PMU events database.
It exercises jevents CounterIDMask handling locally and is explicitly=20
marked as not for upstreaming.

> diff --git a/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json b/too=
ls/perf/pmu-events/arch/riscv/qemu/virt/events.json
> new file mode 100644
> index 0000000000000..294c4ed645f67
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json
> @@ -0,0 +1,26 @@
> +[
> +  {
> +    "EventName": "fake-json-any",

[Severity: Medium]
Since the commit subject specifies this is for testing and should not be
upstreamed, does this patch need to be dropped from the series before it
is merged?=20

Merging this into the mainline kernel would pollute the production PMU even=
ts
database with artificial test events that have no meaning on real hardware.

> +    "EventCode": "0xF10",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-counter_de=
legation-v7-0-0ba2fd34614e@meta.com?part=3D22
