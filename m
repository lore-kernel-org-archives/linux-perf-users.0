Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE923312A;
	Mon,  9 Dec 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758014; cv=none; b=UlB3ltA66SihnFFJG7jdEQL5QNxS/nnoaddCw3I9nJFm5Kq+f3qfXgZmVSIvpY2FXcJKfNp/oTqm/Q41KWO59D44N/ivuCtU0oxx3l/oaAcFpdiWF2g9PlvKuqx96f4+9CZJJTfwIl/6lbTmFrMDD41pxZRL6SPRso+pdpefynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758014; c=relaxed/simple;
	bh=jX2fG3yy1vClj8I8QX5XNbxjsW2ue2euNd6qooAXzig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIK6V0mhRt6xFIS//TngFEL8KWgR4knWUTeTw4v+/8gE77bUGeVD783Qa8cNTh/k/nzyRJrw9Tg9fIqwD+Y9ePE3BG7IWiKP4zFMfx+JUnOd8IYtki81cQRfuOX6FRrkbYyhlXKXYNiqvcDqaW78YCteODRhEWy0Q5u+SXt4Ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mug28Atf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mug28Atf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED98C4CED1;
	Mon,  9 Dec 2024 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733758014;
	bh=jX2fG3yy1vClj8I8QX5XNbxjsW2ue2euNd6qooAXzig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mug28Atfp1fKyAIC1Jocey/QGugRYe/PCDC88Lc3dwW6/WNXMIHl4X6SSizQBIPg5
	 EQrMMc3W8hrxo332Syv++PG4SXEka0yYe80jlt1xOpyPqGlaLAO4LpdTBceHTxhD69
	 fGrXwyRGs0moRzwI/EI0OQxBPpVkyMWjIRAacPGyvrTzMLgXinfyAOE7+rYNjp40bu
	 s7X9AY0meLtYVhUwKmbTwbKi02NAgaqTdZoHN+1aT5FZsgZK0qWW3aWtaE90GHt6tL
	 7mvhqEW3u/ylcOSh9IaJrgN7UYYmwqHDJSBXDh5xeJSGbhW5OwtaCfzYN+viG5jlS1
	 c0nEzasbfEZwA==
Date: Mon, 9 Dec 2024 12:26:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf arm-spe: Add support for SPE Data Source
 packet on AmpereOne
Message-ID: <Z1cMNiWELdUJy2QH@x1>
References: <20241108010911.58412-1-ilkka@os.amperecomputing.com>
 <20241108010911.58412-3-ilkka@os.amperecomputing.com>
 <20241108145138.GF47850@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108145138.GF47850@e132581.arm.com>

On Fri, Nov 08, 2024 at 02:51:38PM +0000, Leo Yan wrote:
> On Fri, Nov 08, 2024 at 01:09:11AM +0000, Ilkka Koskinen wrote:
> > 
> > Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.
> > 
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Thanks, applied to perf-tools-next,

- Arnaldo
 
> > ---
> >  .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 ++++
> >  tools/perf/util/arm-spe.c                     | 44 +++++++++++++++++++
> >  2 files changed, 53 insertions(+)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > index 358c611eeddb..4bcd627e859f 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > @@ -67,6 +67,15 @@ enum arm_spe_common_data_source {
> >         ARM_SPE_COMMON_DS_DRAM          = 0xe,
> >  };
> > 
> > +enum arm_spe_ampereone_data_source {
> > +       ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE    = 0x0,
> > +       ARM_SPE_AMPEREONE_SLC                           = 0x3,
> > +       ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE             = 0x5,
> > +       ARM_SPE_AMPEREONE_DDR                           = 0x7,
> > +       ARM_SPE_AMPEREONE_L1D                           = 0x8,
> > +       ARM_SPE_AMPEREONE_L2D                           = 0x9,
> > +};
> > +
> >  struct arm_spe_record {
> >         enum arm_spe_sample_type type;
> >         int err;
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index dfb0c07cb7fe..df84933b673d 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -455,8 +455,14 @@ static const struct midr_range common_ds_encoding_cpus[] = {
> >         {},
> >  };
> > 
> > +static const struct midr_range ampereone_ds_encoding_cpus[] = {
> > +       MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
> > +       {},
> > +};
> > +
> >  static const struct data_source_handle data_source_handles[] = {
> >         DS(common_ds_encoding_cpus, data_source_common),
> > +       DS(ampereone_ds_encoding_cpus, data_source_ampereone),
> >  };
> > 
> >  static void arm_spe__sample_flags(struct arm_spe_queue *speq)
> > @@ -548,6 +554,44 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
> >         }
> >  }
> > 
> > +/*
> > + * Source is IMPDEF. Here we convert the source code used on AmpereOne cores
> > + * to the common (Neoverse, Cortex) to avoid duplicating the decoding code.
> > + */
> > +static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *record,
> > +                                                union perf_mem_data_src *data_src)
> > +{
> > +       struct arm_spe_record common_record;
> > +
> > +       switch (record->source) {
> > +       case ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE:
> > +               common_record.source = ARM_SPE_COMMON_DS_PEER_CORE;
> > +               break;
> > +       case ARM_SPE_AMPEREONE_SLC:
> > +               common_record.source = ARM_SPE_COMMON_DS_SYS_CACHE;
> > +               break;
> > +       case ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE:
> > +               common_record.source = ARM_SPE_COMMON_DS_REMOTE;
> > +               break;
> > +       case ARM_SPE_AMPEREONE_DDR:
> > +               common_record.source = ARM_SPE_COMMON_DS_DRAM;
> > +               break;
> > +       case ARM_SPE_AMPEREONE_L1D:
> > +               common_record.source = ARM_SPE_COMMON_DS_L1D;
> > +               break;
> > +       case ARM_SPE_AMPEREONE_L2D:
> > +               common_record.source = ARM_SPE_COMMON_DS_L2;
> > +               break;
> > +       default:
> > +               pr_warning_once("AmpereOne: Unknown data source (0x%x)\n",
> > +                               record->source);
> > +               return;
> > +       }
> > +
> > +       common_record.op = record->op;
> > +       arm_spe__synth_data_source_common(&common_record, data_src);
> > +}
> > +
> >  static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
> >                                         union perf_mem_data_src *data_src)
> >  {
> > --
> > 2.47.0
> > 
> > 
