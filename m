Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B411D86DC;
	Wed, 12 Feb 2025 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350493; cv=none; b=pbRXpTgEP7VHKEc7sQNO2jimagaM30+6+OdH4FM9Wt1JxKuhH3EnaJO3fMbvKT4v/cY6vVN2S9puXTW87mpcihQB74aAMPlw4BZNiCz0TDdOTbMBRVTdtpPD/cjSuk+ZO0UvyLf9Iqx9x7NKC027IQokHOTIIQA24XMQ36joGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350493; c=relaxed/simple;
	bh=q4qjlXSbEk4GE+l8gdUlOYcqXFlyOKo7nv5rvR/GczM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roqs7wnls5MKRf+ABTdtrhmOwGjLGb9oOff6ZiycoTYVYPBYACq/PgIN5DYVe8M4nnrPUZtAArA9y/lFZwl2InDiV7q/RNUmBOuXYQPdvDniXUJ2pOpeE2xF0NwsCUnQNAXe24gw+upngabv2UNgEL/QjFJCg5d6KLDzYQAveX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9D0413D5;
	Wed, 12 Feb 2025 00:55:04 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6925B3F58B;
	Wed, 12 Feb 2025 00:54:43 -0800 (PST)
Date: Wed, 12 Feb 2025 08:54:39 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Graham Woodward <graham.woodward@arm.com>
Subject: Re: [PATCH v1 00/11] perf script: Refactor branch flags for Arm SPE
Message-ID: <20250212085439.GA235556@e132581.arm.com>
References: <20250205121555.180606-1-leo.yan@arm.com>
 <CAP-5=fUH6X2F5S5eH+iU+-hT0vNvMKPTqbGt=E9W06sG=MzxEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUH6X2F5S5eH+iU+-hT0vNvMKPTqbGt=E9W06sG=MzxEg@mail.gmail.com>

Hi Ian,

On Tue, Feb 11, 2025 at 02:34:46PM -0800, Ian Rogers wrote:
> On Wed, Feb 5, 2025 at 4:16 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > This patch series refactors branch flags for support Arm SPE.  The patch
> > set is divided into two parts, the first part is for refactoring common
> > code and the second part is for enabling Arm SPE.

[...]
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Built and tested (on x86). A little strange patch 5 adds a new bit not
> at the end, but "Sample parsing" test wasn't broken so looks like it
> is good. I was surprised the use of value in the union:
> ```
> struct branch_flags {
> union {
> u64 value;
> struct {
> u64 mispred:1;
> u64 predicted:1;
> ...
> ```
> didn't get broken. Perhaps there's an opportunity for additional tests.

If the branch stack's flag sticks to a hardware format, then the patch 5
is concerned.  My understanding is the branch flag is a synthesized
value (see intel_pt_lbr_flags() for x86).  So it is fine for rearrange
the bit layout.

The "Sample parsing" test is for big/little endian test, it does not
test for specific bit ordering, this is why the test passes.

If you think it is safer to move the new added bit at the tail of the
bit definitions (just before the 'reserved' field), I can send a new
version for this.  Please let me know your preference.

Thanks for review and test!

Leo
