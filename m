Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139E1DF96A;
	Thu, 17 Oct 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183162; cv=none; b=sGf9Zd1TYA9TY952x7NGlyBnosTX21FCzLizZ1S36kh1m6TR6KuUCTc3GLEi7W4i4Dsv120gBoxw5BeFVngZ8nDbf0GaZTV8OjQChXwv3XIZGCB69iYXS12bbVPdPR9SvtsHP27dt9Rm7YF7g6KSjrrxv3U63p7iEhcnkwkspIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183162; c=relaxed/simple;
	bh=cOKKWhh4cH54ijyTYF/dhdvlBiofHanqyemxRApam/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mOKnh83vjJNAuKvIQcUtj+DRxu7QVCBsbuMfZtc9YirQni/StK0CIM88G8ai3AMODogNYz3reXaKs8Gi+jQODvHNj3mj1KJ94cz1jIoQA65AhXRBVjB4sLH1vG4gr4iy+3IFCiJlMxtVwF3XVAI/KJFivSFaHTUocdKbgVUdKjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2+EarCM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2+EarCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D34C4CED0;
	Thu, 17 Oct 2024 16:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183161;
	bh=cOKKWhh4cH54ijyTYF/dhdvlBiofHanqyemxRApam/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q2+EarCMJB8qYHH0x5PU3mu7w8XLt1gZYteP8OI3HbJfooSJBc+fxWZEvRYSBu8Qr
	 nu0dkZGzpTqw4bSlMIXI/4S+YyT0DCSkUUbh5Auc4TLkVv9YxK580ujKMKgnusSK8V
	 bRAuTIVngcVYablwOdIk6LjaK3oOg0feJ9CBDQ4Qjkg2VyfPB7n/brG1ZipbFmCXVS
	 grvoyIFelNqUbbrsewgSGkBXxzsecYzqAzvGm6GyC1al9C53Rlbs5jymJqO/QPS3aQ
	 UeT/sWRQ7my+7v1kF81yZsWFS4qqDtV5onH3etDhwKMY9UjFOKBg2D/bNAt4SdXsze
	 WAZDX89s1VC3w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
 German Gomez <german.gomez@arm.com>, 
 Carsten Haitzler <carsten.haitzler@arm.com>
In-Reply-To: <20241016065654.269994-1-namhyung@kernel.org>
References: <20241016065654.269994-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf test: Speed up some tests using perf list
Message-Id: <172918316105.639809.18120373431908950671.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 09:39:21 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 15 Oct 2024 23:56:54 -0700, Namhyung Kim wrote:

> On my system, perf list is very slow to print the whole events.  I think
> there's a performance issue in SDT and uprobes event listing.  I noticed
> this issue while running perf test on x86 but it takes long to check
> some CoreSight event which should be skipped quickly.
> 
> Anyway, some test uses perf list to check whether the required event is
> available before running the test.  The perf list command can take an
> argument to specify event class or (glob) pattern.  But glob pattern is
> only to suppress output for unmatched ones after checking all events.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

