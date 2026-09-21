Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522C391E58;
	Mon, 21 Sep 2026 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018771; cv=none; b=CZAWvxes1jUkIkHXxJAf0H7B3jqtHIiKsD3CwgFYhbpE5Lj8X1fH4LQcHS5UDbKXrCF20A8LEuDebUaFoxDfkGs/ErUcDG5p9zltt4VbxjG0CzVsWyg5u8mJIyqJkbIIiVr/RatWfcTiVDoXAD8tV76TBcek1M5YpeDRUmDD8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018771; c=relaxed/simple;
	bh=v1Tjn680AuPFZogHeJdCGgwqc/iXLzCxyvPFCI5K188=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yiq02fEV0cmfvXCrUQ+PKalLXUGnc3NOXafAAe1MWMKQqv+L845pv9glWvhr7igC2jQyUnk6PiH6HZ7wXebu71CR57ZvWhtXWBy4REFjtCjHFojXDWzsBIP0Ec81d2oqIPRPYm2bw8kUUwjDQ9K2CH8P8RE+fFfewEUdhLGsoTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYOk1t/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYOk1t/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89671F000FF;
	Mon, 21 Sep 2026 19:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018769;
	bh=v1Tjn680AuPFZogHeJdCGgwqc/iXLzCxyvPFCI5K188=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fYOk1t/NnpISBnlZqbs2e7hsBnOTxvJEpzJWPHk6jlWEVQtkFYbWhXXYlDHmFdg5N
	 V3KwP6vgT18T8YQi3XvLPaFXg8ADu6z/5CsMM4RbDU5ceRuuyFUiE/8Rcn8WH0QzAC
	 diBFj1zrB2fRjOdMiNvtFLRBv4RTvsYpNz476H81GGUnlNkmpspb9hrcuqen34RRbs
	 3fG/8AC3tAe4qXmmmKVtBZDXJBepds5Mk9SuweO/m5UEOK2BJ4zzBtSYMcHwmbwjFk
	 vwT6vIlafMQv/z0ZYnGptLRmqSQ7y3iW/fi2JzXrUIvvEG62GCVUQU9H+EKW408eFe
	 +QuQ2LqowAi6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] KVM: VMX: Only tell perf to enable PEBS
 counters for fully enabled PMCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260921191418.950933-10-seanjc@google.com>
References: <20260921191418.950933-1-seanjc@google.com>
 <20260921191418.950933-10-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:26:09 +0000
Message-Id: <20260921192609.B89671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When passing the guest's requested PEBS_ENABLE (or rather, KVM's version
> of PEBS_ENABLE on behalf of the guest), omit counters that are locally
> disable and/or don't have a perf event (due to contention), in addition to
> omitting counters that are cross-mapped in the host.
>=20
> In practice, this should be a nop as perf will already have disabled the
> associated counter, i.e. cpuc->pebs_enabled should have been cleared, but
> paranoia is cheap, and the existing code _looks_ wrong.
>=20
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191418.9509=
33-1-seanjc@google.com?part=3D9

