Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D601FF1B3;
	Wed, 11 Dec 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937823; cv=none; b=IkJN1YD03T8kp82GQ1WS5mPJ1C6AiBSXT5CeeEg3ALLxdBg4G9zJlqv431Pmn+DN976LWLWMKXJrGM5tLpxmd9TidnsMAzPEMiM0njV8AV6K8o9/6BLW4CyVkvNGPvgP4V0+JCTSXlj2uLL+EvQyMNlOo+3UFNyxsYRtCG0/VCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937823; c=relaxed/simple;
	bh=zTjvFwmr3yasqKFbJ6Nth7GhuiW+kEeFWzBaX1b7ntA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jgYPsucaG010kJ+iiudLwf+3aOaNMXLgxK1+VA296UtTMBggQ/kxVQP0DDtiaooGxQ3/2i3zCBTNX5q7GfnH0N35Fe82bGhHyY2dzsPHEPCEAd1O/Wf93VhpxKgyQE7FE03aTXLZoqbUteEfdKUlCNOGVxiwlm85sDIGF/JiGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4cp4HGK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4cp4HGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F75C4AF09;
	Wed, 11 Dec 2024 17:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733937823;
	bh=zTjvFwmr3yasqKFbJ6Nth7GhuiW+kEeFWzBaX1b7ntA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=h4cp4HGKMOGD+ourAqPacFryx2hh5EHulWdtpizycsrglolxxesIHKjXOTFwXrntA
	 U6iu6tWjDifFvdzcZ9GzELtxX99P41gylRYFmOOo623VJD1he0Xf1OITJ+T83u9afP
	 /eueUvoLfZzWOnr5cPew9JX9d5DNPL2yRNMNW1Mp67eXR6S/QQV+UsFSnjl63oYdKp
	 HqRIZoGfmH9oVTrXy4rEUrZcgX99jhVw1HEu4LrDlYYKAcSHRNBRO46iQgRoihRQ6U
	 iLcjnSHdyIjaAvU/ZiKiYts8aIQlbOI04/wkwxvV10UcMuYUSrHcziK+ck8/TiwEy3
	 vtRG5JZHh4d5w==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241206042306.1055913-1-irogers@google.com>
References: <20241206042306.1055913-1-irogers@google.com>
Subject: Re: [PATCH v1 1/2] perf hwmon_pmu: Use openat rather than dup to
 refresh directory
Message-Id: <173393782275.3536107.5111642491226236063.b4-ty@kernel.org>
Date: Wed, 11 Dec 2024 09:23:42 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 05 Dec 2024 20:23:05 -0800, Ian Rogers wrote:

> The hwmon PMU test will make a temp directory, open the directory with
> O_DIRECTORY then fill it with contents. As the open is before the
> filling the contents the later fdopendir may reflect the initial empty
> state, meaning no events are seen. Change to re-open the directory,
> rather than dup the fd, so the latest contents are seen.
> 
> Minor tweaks/additions to debug messages.
> 
> [...]

Applied to perf-tools, thanks!

Best regards,
Namhyung

