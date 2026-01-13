Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E72DB7AE;
	Tue, 13 Jan 2026 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338880; cv=none; b=OrpyCHrltY7Q27K7UUFBD2aJZh6NsFyfrpoB0+0T6fdPPJxPsD6NMvfFqZKOJK+a3lMqFy/M+uC787caw+q1f74GffnVfmlzwhwHmKhEps2oh+H/1wIs67XbUUiqsQLWQHSrgnr43XBLU99ISlFsVz2o/hUPO+4Y0q9n0mphyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338880; c=relaxed/simple;
	bh=xTXUTykfqGlTV6r9dOoKmHciVzcitn9XiwZeJVXXxCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQDb3Jd0LyZemuC75zsji8l/AHeuUzkVwJsjwVt0fNvmUhAYzCpnqLf77+D4dKTMShAiQtjjQbSOOPhjj3PoL0m9PFPX8uQj9BM085i1uvQi3KpXhpbMlm4rjoWrdKcv0Bjg3N3y3llVWK7Fg4rgBHEa9OaU/gilrNUDLg/JYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnoovRlg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnoovRlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6F1C116C6;
	Tue, 13 Jan 2026 21:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768338880;
	bh=xTXUTykfqGlTV6r9dOoKmHciVzcitn9XiwZeJVXXxCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnoovRlgaXeN+Xu4fGtbvNwr+KnNk1PMiJ175+g4zU3QAvxOuMIWzXoxYbUL66fUq
	 aq2uUzwBre6sQnj7UGjky2uZTq394q44uJt7xG9TuRlsB0HZr9ajR+hjnqKBJe/MmW
	 dNbk+n3Il/8A7kBt2LRCLT4f5dFZgm8dxK54YorYinrvofQmEOodK8cKPjmxZDFZhN
	 zd+NcEnnzEP5hfDrUsKDoqGHkiNiqHqrF94Qa4PE+Nm4G9hHtRhmyq7uOxtO5pEkK9
	 t7ymRRqmpDOaJ58G4VbHlOgxxmbL5MuTCP32zsTjD5Sf7Ircwgml7K3nhSc36O5BUq
	 MtndWPZkEVxfA==
Date: Tue, 13 Jan 2026 18:14:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Manuel =?iso-8859-1?Q?Hern=E1ndez?= | OPENCHIP <manuel.hernandez@openchip.com>,
	"acme@redhat.com" <acme@redhat.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"alex@ghiti.fr" <alex@ghiti.fr>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"eric.lin@sifive.com" <eric.lin@sifive.com>,
	"inochiama@gmail.com" <inochiama@gmail.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"pjw@kernel.org" <pjw@kernel.org>,
	"samuel.holland@sifive.com" <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] perf vendor events riscv: Add CVA6 JSON file
Message-ID: <aWa1vWN1c2oNPoZ1@x1>
References: <CAP-5=fWmyyp2HTwOtbcJbSR1OO3qCh+sqdua=QmwNa04k8sS6w@mail.gmail.com>
 <20251204163854.10318-1-manuel.hernandez@openchip.com>
 <CAP-5=fUKnepwqKm+9kk+NQZYe8jsaKZuYgxhVUKGrFMimUE6pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUKnepwqKm+9kk+NQZYe8jsaKZuYgxhVUKGrFMimUE6pA@mail.gmail.com>

On Thu, Dec 04, 2025 at 08:43:51AM -0800, Ian Rogers wrote:
> On Thu, Dec 4, 2025 at 8:40 AM Manuel Hernández | OPENCHIP
> <manuel.hernandez@openchip.com> wrote:
> >
> > From: Manuel Hernández Méndez <manuel.hernandez@openchip.com>
> >
> > This patch add the CVA6 JSON file.
> >
> > Signed-off-by: Manuel Hernández Méndez <manuel.hernandez@openchip.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied, and added a tad more info to the cset log message:

    This patch add the OpenHW Core-V CVA6 Risc-V JSON file.

    For more info:

    https://openhwfoundation.org/news/2023/11/07/openhw-group-announces-core-v-cva6-platform-project-for-risc-v-software-development-and-testing/

:-)

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> > Hi Ian, thanks for the review.
> >
> > This is the second version of the patch, following a review of the
> > CVA6 core PMU implementation.
> >
> > Thanks!
> > Manuel
> > ---
> > Changes in v2:
> > - Added a clarification about retired instructions in name and
> >   description fields
> > - Moved and renamed LOAD_ACCESSES and STORE_ACCESSES events from
> >   memory.json to instructions.json
> > - Moved INSTRUCTION_FETCH_EMPTY event from instructions.json to
> >   microarch.json
> > - Changed mode from 755 to 644 in firmware.json file
> >
> > v1:
> > https://lore.kernel.org/all/20251202180155.11147-1-manuel.hernandez@openchip.com/
> > ---
> >  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
> >  .../arch/riscv/openhwgroup/cva6/firmware.json | 68 +++++++++++++++++++
> >  .../riscv/openhwgroup/cva6/instructions.json  | 47 +++++++++++++
> >  .../arch/riscv/openhwgroup/cva6/memory.json   | 42 ++++++++++++
> >  .../riscv/openhwgroup/cva6/microarch.json     | 27 ++++++++
> >  5 files changed, 185 insertions(+)
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/firmware.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/instructions.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/memory.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/microarch.json
> >
> > diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> > index d5eea7f9aa9a..87cfb0e0849f 100644
> > --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> > +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> > @@ -21,5 +21,6 @@
> >  0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+,v1,sifive/p650,core
> >  0x5b7-0x0-0x0,v1,thead/c900-legacy,core
> >  0x5b7-0x80000000090c0d00-0x2047000,v1,thead/c900-legacy,core
> > +0x602-0x3-0x0,v1,openhwgroup/cva6,core
> >  0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
> >  0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
> > diff --git a/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/firmware.json b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/firmware.json
> > new file mode 100644
> > index 000000000000..7149caec4f80
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/firmware.json
> > @@ -0,0 +1,68 @@
> > +[
> > +  {
> > +    "ArchStdEvent": "FW_MISALIGNED_LOAD"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_MISALIGNED_STORE"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_ACCESS_LOAD"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_ACCESS_STORE"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_ILLEGAL_INSN"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_SET_TIMER"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_IPI_SENT"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_IPI_RECEIVED"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_FENCE_I_SENT"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
> > +  },
> > +  {
> > +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
> > +  }
> > +]
> > diff --git a/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/instructions.json b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/instructions.json
> > new file mode 100644
> > index 000000000000..c38f6c97cf1f
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/instructions.json
> > @@ -0,0 +1,47 @@
> > +[
> > +  {
> > +    "EventName": "LOAD_INSTRUCTIONS_RETIRED",
> > +    "EventCode": "0x5",
> > +    "BriefDescription": "number of data memory load instructions retired"
> > +  },
> > +  {
> > +    "EventName": "STORE_INSTRUCTIONS_RETIRED",
> > +    "EventCode": "0x6",
> > +    "BriefDescription": "number of data memory store instructions retired"
> > +  },
> > +  {
> > +    "EventName": "EXCEPTIONS",
> > +    "EventCode": "0x7",
> > +    "BriefDescription": "valid exceptions encountered"
> > +  },
> > +  {
> > +    "EventName": "EXCEPTION_HANDLER_RETURNS",
> > +    "EventCode": "0x8",
> > +    "BriefDescription": "return from an exception"
> > +  },
> > +  {
> > +    "EventName": "BRANCH_INSTRUCTIONS_RETIRED",
> > +    "EventCode": "0x9",
> > +    "BriefDescription": "number of branch instructions encountered retired"
> > +  },
> > +  {
> > +    "EventName": "CALL_INSTRUCTIONS_RETIRED",
> > +    "EventCode": "0xC",
> > +    "BriefDescription": "number of call instructions retired"
> > +  },
> > +  {
> > +    "EventName": "RETURN_INSTRUCTIONS_RETIRED",
> > +    "EventCode": "0xD",
> > +    "BriefDescription": "number of return instructions retired"
> > +  },
> > +  {
> > +    "EventName": "INTEGER_INSTRUCTIONS_RETIRED",
> > +    "EventCode": "0x14",
> > +    "BriefDescription": "number of integer instructions retired"
> > +  },
> > +  {
> > +    "EventName": "FLOATING_POINT_INSTRUCTIONS_RETIRED",
> > +    "EventCode": "0x15",
> > +    "BriefDescription": "number of floating point instructions retired"
> > +  }
> > +]
> > diff --git a/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/memory.json b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/memory.json
> > new file mode 100644
> > index 000000000000..c4f376a0ee4e
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/memory.json
> > @@ -0,0 +1,42 @@
> > +[
> > +  {
> > +    "EventName": "L1_I_CACHE_MISSES",
> > +    "EventCode": "0x1",
> > +    "BriefDescription": "number of misses in L1 I-Cache"
> > +  },
> > +  {
> > +    "EventName": "L1_D_CACHE_MISSES",
> > +    "EventCode": "0x2",
> > +    "BriefDescription": "number of misses in L1 D-Cache"
> > +  },
> > +  {
> > +    "EventName": "ITLB_MISSES",
> > +    "EventCode": "0x3",
> > +    "BriefDescription": "number of misses in ITLB"
> > +  },
> > +  {
> > +    "EventName": "DTLB_MISSES",
> > +    "EventCode": "0x4",
> > +    "BriefDescription": "number of misses in DTLB"
> > +  },
> > +  {
> > +    "EventName": "L1_I_CACHE_ACCESSES",
> > +    "EventCode": "0x10",
> > +    "BriefDescription": "number of accesses to instruction cache"
> > +  },
> > +  {
> > +    "EventName": "L1_D_CACHE_ACCESSES",
> > +    "EventCode": "0x11",
> > +    "BriefDescription": "number of accesses to data cache"
> > +  },
> > +  {
> > +    "EventName": "L1_CACHE_LINE_EVICTION",
> > +    "EventCode": "0x12",
> > +    "BriefDescription": "number of data cache line eviction"
> > +  },
> > +  {
> > +    "EventName": "ITLB_FLUSH",
> > +    "EventCode": "0x13",
> > +    "BriefDescription": "number of ITLB flushes"
> > +  }
> > +]
> > diff --git a/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/microarch.json b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/microarch.json
> > new file mode 100644
> > index 000000000000..104e6e8197da
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/microarch.json
> > @@ -0,0 +1,27 @@
> > +[
> > +  {
> > +    "EventName": "BRANCH_MISPREDICTS",
> > +    "EventCode": "0xA",
> > +    "BriefDescription": "number of branch mispredictions"
> > +  },
> > +  {
> > +    "EventName": "BRANCH_EXCEPTIONS",
> > +    "EventCode": "0xB",
> > +    "BriefDescription": "number of valid branch exceptions"
> > +  },
> > +  {
> > +    "EventName": "MSB_FULL",
> > +    "EventCode": "0xE",
> > +    "BriefDescription": "scoreboard is full"
> > +  },
> > +  {
> > +    "EventName": "INSTRUCTION_FETCH_EMPTY",
> > +    "EventCode": "0xF",
> > +    "BriefDescription": "number of invalid instructions in IF stage"
> > +  },
> > +  {
> > +    "EventName": "PIPELINE_STALL",
> > +    "EventCode": "0x16",
> > +    "BriefDescription": "number of cycles the pipeline is stalled during read operands"
> > +  }
> > +]
> > --
> > 2.34.1
> >
