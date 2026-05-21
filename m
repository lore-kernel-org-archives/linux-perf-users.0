Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB28349CD0
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375195; cv=none; b=VQc3+LSj78zRSRlByjgdnvQcx/HpyQeVFFqZHUj5on6nzIwGk/YAwahmKb2m0qV5K/HwLIhV2ew6hrFrsrDjckeiRWVAF63RjIt8P3SyFf6hVTOw0rDua9gEeoCb3Bb99OGk+OQ/4F0bW8RGs7GRKGyCipVLlRExMzqDclbwyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375195; c=relaxed/simple;
	bh=MIUjzxd2Xin0+u3iL92WWv0727XnGMfBuSkWq6+9KN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t3zBOVqubqk2Fz2T8/9b+esZczTTUQQy6HwIsgiccdbFhzzcO2Tw4wEP2gbbJ4HNjt8NCPmYrJwV7vs0g+4ch7Twj7eeZdiEiUhgovTUoDiZInzLk/Q9V29WJ403649guckE/9Cs3Ji4bzKL162Rk41z4Qy4uINyq3e9/mRwtM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxsMvpc0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxsMvpc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013C51F00A3B;
	Thu, 21 May 2026 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375194;
	bh=mnCva2JH6fVL63rdni9pwxkgMkFiAJU7v0PgmiSRwnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XxsMvpc0o5A3sqhWg+XI6AdneBjn9k5PzGwtGDLugV46d/l9aVWstvPaUZdVzg7LK
	 l+s2msDHE3P3yw8t91wGSZjKfShxv7NN+myudbH3CES21KHrJ/3OLLjqG7JwgKMz2Z
	 mR3wWwPOOEQVXLYxXvNMgMhdlGnBlEvfIZSVTd0Te4YTF+jTfoVsWm4ewoN8waKPdN
	 hVgCvuMFi07DLXf7h/F1MpoNdmCTrzjlU6mIPYONEkLrzS5aQtxmevs3+yHoFLCi78
	 Muy99c1CNv1x4FvepA9ahmNENiyABkXm/Eq5Zrojm1Ra+YmmtsmhUSwVZNSm0mZAN5
	 lGNvpJxiVpolw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] rtla: Fix output files in source tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Hutchings" <benh@debian.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ag8YLYKZTKOq0t4x@decadent.org.uk>
References: <ag8YLYKZTKOq0t4x@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 14:53:13 +0000
Message-Id: <20260521145314.013C51F00A3B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] `make clean` fails to remove the generated `$(OUTPUT)tests/bpf/bpf_=
action_map.o` file during out-of-tree builds.
--

commit ce6ce36bb0778cda3451364e21ac622e234e5df7
Author: Ben Hutchings <benh@debian.org>

rtla: Fix output files in source tree

This commit updates the rtla Makefile to place several generated BPF object
files and the skeleton header into the output directory to support fully
out-of-tree builds. It adds the $(OUTPUT) prefix to these files in the build
rules, tests, and the clean target.

> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 45690ee14544d..f54da7be735da 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
[ ... ]
> @@ -111,10 +118,10 @@ clean: doc_clean fixdep-clean
>  	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*=
.d' -delete
>  	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
>  	$(Q)rm -rf feature
> -	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_a=
ction.o
> +	$(Q)rm -f $(OUTPUT)src/timerlat.bpf.o $(OUTPUT)src/timerlat.skel.h $(OU=
TPUT)example/timerlat_bpf_action.o

[Severity: Low]
Does this leave $(OUTPUT)tests/bpf/bpf_action_map.o behind after a clean?

Previously, tests/bpf/bpf_action_map.o was cleaned up by the find command on
the first line of this target. Now that it is placed in the $(OUTPUT) direc=
tory,
the find command might not reach it during an out-of-tree build, and it does
not appear to be included in this explicit rm command either.

>  	$(Q)rm -f $(UNIT_TESTS)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ag8X7gcDw6jpJsLq@de=
cadent.org.uk?part=3D1
