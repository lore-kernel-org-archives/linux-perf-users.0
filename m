Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB8BA3F;
	Sun,  9 Jun 2024 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717900436; cv=none; b=p19dZFTprwSjcHQLw3PWYR1TmTGcv19H+YOxbT/FbUVwLY/8Wit1aPKAQqGZrF7zU9W6wuU6PGl8qg10lvCqRse7oeDXqa5qKXAW2howR80vieap8zSddVZc31cymZk47eigG618DDkLmnG0UfCOAZNOLXKIElFiDl++OI9zjzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717900436; c=relaxed/simple;
	bh=vFzD5CwfW61AglA18pEmzGwU/uy+YazwZm7RooPPHh0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jO9EeAYtM3xn3p7YLJZJ7DjsGK91U4xyXY9+v2PBMt2wJORaLwABcmNOV8ekcsFSB6j44Ldit2/XUSopjjiXzwB/RpzOKvB46Pgb+hOXZxSbsxWPUAxh88z2wNOWhx9+TrEmIXwhj/qDVFt00hJt/fkCXV5haetuyc+68PZWArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPZCuDyq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPZCuDyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C7BC2BD11;
	Sun,  9 Jun 2024 02:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717900435;
	bh=vFzD5CwfW61AglA18pEmzGwU/uy+YazwZm7RooPPHh0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cPZCuDyqbMQM6c6/H0FGkv5ZzYTnehHcKmVXcfSBbug0QTKIAHa/n1bVsU76hmROt
	 czw8Rd0t337CL1SVeK3OAQj6JD2jCyHp0u8VI4n1jxZ3uTIsb9V2xGO9p9eexiNqKM
	 H91lv+p/SMoP9rk/7Ml/TkTDOE2S5Ep9BbhwbQp2nvJYR8EIervb0p+O0PGy3Gfon9
	 ulHi09BiouGX9QJeDwn9PiDhA/fceL2I/Op+nd1FUVyuEkXZrDiYRnRYFxgka/znmc
	 piklqFPL+DeT1x4Xp0bmITlsNPEtj6SpBOGk7kH4oXyUYiTdllShHC41c6A7qCcVzn
	 M2uQ3AL+qkSAg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>
Subject: Re: [RFC PATCH v1 1/2] perf stat: Make options local
Date: Sat,  8 Jun 2024 19:33:50 -0700
Message-ID: <171790038047.3969172.4557029271770299391.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240605063828.195700-1-irogers@google.com>
References: <20240605063828.195700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 04 Jun 2024 23:38:27 -0700, Ian Rogers wrote:

> Reduce the scope of stat_options to cmd_stat, and pass as an argument
> to __cmd_record. This is done to make more localized changes to the
> options in later patches. A side-effect of the change is to reduce the
> size of a stripped PIE perf binary by 5952 bytes. The savings come
> mainly in the dynamic relocation section.
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
