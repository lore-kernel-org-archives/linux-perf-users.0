Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BA2E5B2D
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283619; cv=none; b=Z/KkuOLKvEvFSv8/YNYhk0GOhr3QlW4Ty9NlSNbEwwBkhhhMTtCMqtc6lZutiugQl8NN91EvHwbMUKgzOoebKGquJtBxFVogN+SZLfj0ORJcdM8V07AQU3P9G0bchpcOwYpWj3FWPRr40PiRd5V7/II5l9P8O7TKgKlplVSNQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283619; c=relaxed/simple;
	bh=XnQGXoYnCM6BOA0H+DTO0lhVplmp6oFUSHEIvLX/QKE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BtePT2+8mhJiLxGw7FDZ17SQMQR0Y5ekLm6GO1u0S4IxcKY9t/iJ/sd8NPI/xweAmPLHW2i2m9nf5im7zcmnkkP0CdtuE8T7/mfUOX2aCAHFGd8LnfhCqrv8lGAT8xQjJXH5JUBxW3vW+QVUBjt2KQKmGAXF/Nc/7k4IbyceeOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWYEbs9l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWYEbs9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06AEC2BCB0;
	Fri,  8 May 2026 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778283619;
	bh=XnQGXoYnCM6BOA0H+DTO0lhVplmp6oFUSHEIvLX/QKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MWYEbs9lgwWjGVE5mRdNtBp0AqAvzNjFeO1z/RXqpwxL+WmghPL+nkE0iYEcxbecL
	 S5Lz402iYbJhc3C+eE1x3EujNc/zbwm/D+RFBaia5PJZc8ezSjabRnL6BukZsqCpt5
	 rPTw/Vw/JhttNJ/KLOfyyg8WSCu5/2OVp7OVQF86U0NTm86yITHcp0B4kcUuXVSX7E
	 K+AAj6NZ8/L4CV8vktAfw33nj/wAm/I7HRNwnbcyhD8y3jITsLnX6BJNxIOGEQmny1
	 A3joOTsbOFjCh/t8Sb4fwMDn/jnAECZySON1iM8Ya6iscuZZcLeMAwFBt2xXcRXqp1
	 1rCiK+XV39Yvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] perf/x86/intel: Ensure guest PEBS path doesn't
 set unwanted PERF_GLOBAL_CTRL bits
Reply-To: sashiko@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260508231353.406465-2-seanjc@google.com>
References: <20260508231353.406465-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 23:40:18 +0000
Message-Id: <20260508234018.F06AEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The host PEBS collision check fails to mask non-counter bits, inco=
rrectly disabling guest PEBS for events like Store Latency.
--

Note: The format of this report has been altered due to recitation
restrictions. The original patch code is not quoted directly, and findings =
are
provided as a free-form summary.

commit 39adc53b360e88595a3be6fc59b18b048d9e9921
Author: Sean Christopherson <seanjc@google.com>

perf/x86/intel: Ensure guest PEBS path doesn't set unwanted PERF_GLOBAL_CTR=
L bits

This commit masks the pebs counter values being reinstated into the global
control msr for a guest with perf's desired value. This is done to ensure t=
he
hypervisor doesn't unintentionally enable counters.

In intel_guest_get_msrs(), the host pebs collision check evaluates the host
field of the pebs_enable array entry to determine if the host is actively
using pebs. If it is, guest pebs is disabled.

Is it possible for this check to falsely detect a host collision due to
non-counter bits being set?

When a guest configures a store latency pebs event, a backing perf event is
created. In intel_pmu_pebs_enable(), this sets both the counter index bit
and bit 63 in cpuc->pebs_enabled.

Because the host field is calculated as cpuc->pebs_enabled masked against
the inverse of cpuc->intel_ctrl_guest_mask, and the guest mask exclusively
tracks valid counter indices (never including bit 63), bit 63 remains set in
the host field.

Consequently, the check for whether the host is actively using pebs will
evaluate to true even when only the guest is using pebs. This introduces a
regression where guest pebs is completely disabled, silently breaking guest
store latency events.

Should the host pebs usage evaluation also be masked by intel_ctrl to preve=
nt
non-counter bits from triggering a false collision?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508231353.4064=
65-1-seanjc@google.com?part=3D1
