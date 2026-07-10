Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC80F126C03
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644079; cv=none; b=iKFqjciBOS2yp45qL6hKYP7DpDSO4DoYS8ljXeXwka3h+XPwmk16QeMR/Yq1dZ/QorxZZO908ct+BWA4P2RHReh8B7NKepRmvTYw/UvePEaIy8/ED/JYD6y1N8MUicCxvNxxSCB0Z8E6yQgC0kGXN0721zeVmRrvBS2lkwhNhSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644079; c=relaxed/simple;
	bh=h7dGUDsPHwFpK1rJJAv2vgzE82KNFl0TxXI+8/Ph2Ww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VpLrSoG7lZhNEKRFT8BVugSBEKhHib33Sp8hZT+vBWXRYyea0daItMygP7jZmay5FIEUScNLOx0uwo6iJCvYQJVSXPGMdEmDfHxXt4WyAuiKems0G0HBQWMGHVH7oX92yLEhdAd84rgqU2+AZL+ZYh2cYp1bbdxInev8+vHYbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buHLoKsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buHLoKsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E95E1F00A3E;
	Fri, 10 Jul 2026 00:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783644078;
	bh=WWcQodI24+5dpyj927QkmrAqq9qp/P4Mgjg5xIYPu0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=buHLoKslWixcSphIwn429/LhEaYgO90Z+y69CLtSAWwQ0MN/2HnWOwl99i1pHVAgR
	 N2xHYVqm4KWbjQUpiOwbEIFDZX2r8n5nGCv/fWITuNQ3ZJTpLbdc59P9DC2brcdeaR
	 z0J2CtDTkhzLOybYS697SRwyw9HPz1Zcfy04f2CjSNoZJPm/mScC+Wrre6EItdp94F
	 ASjhVV9zRXFLdw2CHS7k4NKIOjjMj4mPc3DKxvRBHC8ufzoZ72KHiAzqjJ0Smk8tmG
	 1WVS8Y6HeiCm0wZrBoN+Z1sQY+VJmItR0JxT/hEX+UOQNPFGHmrSS5hMpIKXINkFJY
	 8KBJYweietl+w==
From: Namhyung Kim <namhyung@kernel.org>
To: Ivan Lazaric <ivan.lazaric1@gmail.com>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com
In-Reply-To: <20260708131359.71732-3-ivan.lazaric1@gmail.com>
References: <ak3scJT4MfbAg0G4@google.com>
 <20260708131359.71732-3-ivan.lazaric1@gmail.com>
Subject: Re: [PATCH v2] perf stat: reject --field-separator and
 --json-output combination
Message-Id: <178364407841.1457655.15665844687515027767.b4-ty@kernel.org>
Date: Thu, 09 Jul 2026 17:41:18 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Jul 2026 15:14:01 +0200, Ivan Lazaric wrote:
> Specifying --field-separator option is stating you want CSV output.
> Passing both --field-separator and --json-output is then stating
> you want output to be in CSV and JSON format at same time.
> 
> Currently this combination is not rejected, and the outcome
> is a malformed combination of CSV and JSON output.
> This is because of inconsistencies in various printing functions,
> some of them have if-else chains that start with
> "Should I print JSON?", and some start with "Should I print CSV?".
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


