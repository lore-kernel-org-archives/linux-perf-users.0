Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD640D570
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042189; cv=none; b=Tg1yYArbKmns15CPm7wxIvBlDmf+ra9JYCmBFZZ35sr5dDF9M5PvpRgqwejpYLTJgJOUKo0o3/tQw2sfdz0m19TBj0Omv88S5RiCpBfp0/KcL+hn7MyHvUQy4xGnSWQ22A+fH/csBcxOJGVyS+br/dj97RUOPGxQ7RJtPWgXtAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042189; c=relaxed/simple;
	bh=RnfkQhzdrqY7JDsdfx086pdw+pEhiu4qJi0RaWrHb8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=phEtgjXVTOS3slwOjJiAoCcxbLfQzM+8i+kCKfIA2bPtxxbXiQjsh8HAkUNiEFRWjD1r35L9p7lsRO04WmHmi8IvlaXHraC/Rubs1GSGPX2FKVUZFUOEtRG8f/ZbzAgTAl3qLqEaz76bwpZ4N6E/Q8rW0/0SXJnFCFvqyiQwVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqQqChGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqQqChGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA11B1F00893;
	Tue,  9 Jun 2026 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781042188;
	bh=PY0AdPSS0nfz+KHAzXN2EKPL8wsg223nvq5CISEU9T4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cqQqChGg6a7YspSIA2MUXcwTioo/HgT76c4458pewWNRBTbrZpi8253RYgviijWjf
	 ykmpuzwnDKr632yXK+zel5Ptzt4bQUDRruGU1d6DfxMtLDw+p+ODr0BIZsSok+Cq4P
	 ap8RtkbqD0Nw23HsAm0G2YV7b4hBxqqQ3aSZv40wj5IfSf32GUMskvWeWp/JGmYrST
	 D/kY68CDSVlzIF2VOyYrqYeCBM5dqKugUQPVuBe4cTdkjS+2qZXSuqv6EDRPgDQr2z
	 iATuN3mZ8RBTpU/7uhf728SoVrg2FuLKbPfRfm6gzGg8fkpjdRV3K7sMkGgCcFIyLd
	 evNGxVf/701SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/6] perf vendor events intel: Update tigerlake
 events from 1.18 to 1.19
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609215046.2391903-7-ctshao@google.com>
References: <20260609215046.2391903-7-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 21:56:27 +0000
Message-Id: <20260609215627.DA11B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete patch: The commit updates the Tigerlake event version=
 in mapfile.csv but fails to include the actual updated JSON event files.
--

commit 827bd8b5ad34fdfc9cb54712c5bfc0e4b556fa4f
Author: Chun-Tse Shao <ctshao@google.com>

perf vendor events intel: Update tigerlake events from 1.18 to 1.19

This commit updates the tigerlake event version string in mapfile.csv from
1.18 to 1.19 to track the latest Intel perfmon events.

> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-=
events/arch/x86/mapfile.csv
> index 6af3cee12c8a6..a7f8706698272 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
[ ... ]
> @@ -35,7 +35,7 @@ GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
>  GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
>  GenuineIntel-6-55-[01234],v1.37,skylakex,core
>  GenuineIntel-6-86,v1.23,snowridgex,core
> -GenuineIntel-6-8[CD],v1.18,tigerlake,core
> +GenuineIntel-6-8[CD],v1.19,tigerlake,core

[Severity: Medium]
Are the corresponding JSON files for the tigerlake events missing from this
commit?

The patch updates the version string to v1.19 here in mapfile.csv, but it
doesn't include the actual updated JSON event files in the
tools/perf/pmu-events/arch/x86/tigerlake/ directory.

Because jevents.py parses the local JSON files to generate the C event
tables, won't perf continue to be compiled with the outdated v1.18 events
while falsely reporting v1.19?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609215046.2391=
903-1-ctshao@google.com?part=3D6
