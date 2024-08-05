Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14B5464B;
	Mon,  5 Aug 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872587; cv=none; b=j+8yu3TgFwGFhBZQ2RV7NyM0Lnc8jZu/wKaOPi4c8krhl3pP+k9dbD2iNBiW50kQHxwf0amsuaLU2cVvUNU0gyM+i9g5MAbU1aL3ilYzb4Y7vUFYXyaeF9wxBRZENp8pyj6mTgfGh79OmnanFr1dIeOpjFGrxcQ/o+oE7Q1D8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872587; c=relaxed/simple;
	bh=dplMNOpfl+Qd3uRNVqpbWdB9r/3JPgRLkheeqWwikyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkZGO6Uvdi/GZHSednr7C9mYFlA1kzMXhRu2oCu012FsDquJLIj9pFgbs1EAVBE7mjZYZ81V1uvLpOu+A4pVOsUfJzm8R02LhTr+0PpzlMm9Cm+HKqRol9Pt/8rb2LmuJTGXYpNF3kRMg4vy0UEER6FSiE3RV7NXF6tR9DFStrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs6pPLf0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs6pPLf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F7FC4AF0C;
	Mon,  5 Aug 2024 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722872586;
	bh=dplMNOpfl+Qd3uRNVqpbWdB9r/3JPgRLkheeqWwikyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fs6pPLf0Sh0x80jh3k7ZSZ3Pq0FDLptPhOy9Oh3sbEvilA5FnMxwec/sKOR4NalaW
	 RVpGW/fhd+WS0/u/Rpk4Q/G2LVc2bhn9CBEMIXoUFYrdhcxtT0xuwWxPWIHj4S4rCk
	 /x3XG1hs76OeSZypC8egSBpZ8mONnlLZMS4fYuASxU/SgFcNNZP4rL2WGSyBigohZO
	 nwPiubioXbFO6weZcNxSNX5GtaT55NKRQ1Yb+6EYXmx05C41t7Fsn8syNvWQ5eeXBD
	 275df7+Wm4CDPxZqTZv7cgSqzFVt08MimKKmkRUiDjBj7HENV8ePVS4gbm1mKYjPRt
	 y+AL4+pi4qScA==
Date: Mon, 5 Aug 2024 12:43:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Eric Lin <eric.lin@sifive.com>, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, vincent.chen@sifive.com,
	greentime.hu@sifive.com, Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH] perf pmus: Fix duplicate events caused segfault
Message-ID: <ZrDzBrrBPBkSKLRC@x1>
References: <20240719081651.24853-1-eric.lin@sifive.com>
 <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
 <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
 <CAPqJEFqCXd1FWCgB0919r+J0XW7KVX_OWZNdocva-bxcscjTrw@mail.gmail.com>
 <BB8E0B26-4E5F-416F-B8D1-AC745F141383@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BB8E0B26-4E5F-416F-B8D1-AC745F141383@linux.vnet.ibm.com>

On Mon, Aug 05, 2024 at 07:54:33PM +0530, Athira Rajeev wrote:
> 
> 
> > On 4 Aug 2024, at 8:36 PM, Eric Lin <eric.lin@sifive.com> wrote:
> > 
> > Hi,
> > 
> > On Sun, Jul 21, 2024 at 11:44 PM Eric Lin <eric.lin@sifive.com> wrote:
> >> 
> >> Hi Athira,
> >> 
> >> On Sat, Jul 20, 2024 at 4:35 PM Athira Rajeev
> >> <atrajeev@linux.vnet.ibm.com> wrote:
> >>> 
> >>> 
> >>> 
> >>>> On 19 Jul 2024, at 1:46 PM, Eric Lin <eric.lin@sifive.com> wrote:
> >>>> 
> >>>> Currently, if vendor JSON files have two duplicate event names,
> >>>> the "perf list" command will trigger a segfault.
> >>>> 
> >>>> In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
> >>>> pmu_events_table__num_events() gets the number of JSON events
> >>>> from table_pmu->num_entries, which includes duplicate events
> >>>> if there are duplicate event names in the JSON files.
> >>> 
> >>> Hi Eric,
> >>> 
> >>> Let us consider there are duplicate event names in the JSON files, say :
> >>> 
> >>> metric.json with: EventName as pmu_cache_miss, EventCode as 0x1
> >>> cache.json with:  EventName as pmu_cache_miss, EventCode as 0x2
> >>> 
> >>> If we fix the segfault and proceed, still “perf list” will list only one entry for pmu_cache_miss with may be 0x1/0x2 as event code ?
> >>> Can you check the result to confirm what “perf list” will list in this case ? If it’s going to have only one entry in perf list, does it mean there are two event codes for pmu_cache_miss and it can work with either of the event code ?
> >>> 
> >> 
> >> Sorry for the late reply.
> >> Yes, I've checked if there are duplicate pmu_cache_miss events in the
> >> JSON files, the perf list will have only one entry in perf list.
> >> 
> >>> If it happens to be a mistake in json file to have duplicate entry with different event code (ex: with some broken commit), I am thinking if the better fix is to keep only the valid entry in json file ?
> >>> 
> >> 
> >> Yes, I agree we should fix the duplicate events in vendor JSON files.
> >> 
> >> According to this code snippet [1], it seems the perf tool originally
> >> allowed duplicate events to exist and it will skip the duplicate
> >> events not shown on the perf list.
> >> However, after this commit e6ff1eed3584 ("perf pmu: Lazily add JSON
> >> events"),  if there are two duplicate events, it causes a segfault.
> >> 
> >> Can I ask, do you have any suggestions? Thanks.
> >> 
> >> [1] https://github.com/torvalds/linux/blob/master/tools/perf/util/pmus.c#L491
> >> 
> > 
> > Kindly ping.
> > 
> > Can I ask, are there any more comments about this patch? Thanks.
> > 
> Hi Eric,
> 
> The functions there says alias and to skip duplicate alias. I am not sure if that is for events
> 
> Namhyung, Ian, Arnaldo
> Any comments here ?

So I was trying to reproduce the problem here before looking at the
patch, tried a simple:

⬢[acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/cache.json b/tools/perf/pmu-events/arch/x86/rocketlake/cache.json
index 2e93b7835b41442b..167a41b0309b7cfc 100644
--- a/tools/perf/pmu-events/arch/x86/rocketlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/rocketlake/cache.json
@@ -1,4 +1,13 @@
 [
+    {
+        "BriefDescription": "Counts the number of cache lines replaced in L1 data cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "L1D.REPLACEMENT",
+        "PublicDescription": "Counts L1D data line replacements including opportunistic replacements, and replacements that require stall-for-replace or block-for-replace.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of cache lines replaced in L1 data cache.",
         "Counter": "0,1,2,3",
⬢[acme@toolbox perf-tools-next]$ grep L1D.REPLACEMENT tools/perf/pmu-events/arch/x86/rocketlake/cache.json
        "EventName": "L1D.REPLACEMENT",
        "EventName": "L1D.REPLACEMENT",
⬢[acme@toolbox perf-tools-next]$

I.e. duplicated that whole event definition:

Did a make clean and a rebuild and:

root@x1:/home/acme/git/pahole# perf list l1d.replacement

List of pre-defined events (to be used in -e or -M):


cache:
  l1d.replacement
       [Counts the number of cache lines replaced in L1 data cache. Unit: cpu_core]
root@x1:/home/acme/git/pahole# perf list > /dev/null
root@x1:/home/acme/git/pahole#

No crash, can you provide instructions on how to reproduce the problem?

I would like to use the experience to add a 'perf test' to show this
failing and then after the patch it passing that new test.

- Arnaldo


