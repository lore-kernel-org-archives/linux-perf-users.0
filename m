Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E75154427
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615331; cv=none; b=cOk3pFLt/XdJt91pO5mCpM2/SYxY5kohHkP0qzO9pMLbbP+S6/Wrsc0IotEHi6FwinJjOUs/71GrpFhWVIRhFzs/znpd/eY3xBjcQs5EZ6UutbbnCy15aHO//VbGXxua3CqQPFtzh9LWoXbu6NzPLh4I47ryy5Sue2adAgVOwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615331; c=relaxed/simple;
	bh=4PHST+75MmCsC59iF4Z7sYgddRT/S6IfMjcgvunmaa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUeOiqvVn7Gk5uC0wiudSXiQvWhBWnI8bKtuIk4mS6CJOkBgbwsIjLl/OavGHsklzhS9oGCW5EQJrX8rGE26/D9TeZeIlITXaMFPreDilyVwAT4BGsNqxFtek2jvl0ovQUx3wAGGZfeEo7sPXHVi3RtQD0oZ/crPMpuiS8HI5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0OijpHl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0OijpHl"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso290215ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715615329; x=1716220129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYQ0gjixSfurkzUiaxNduoPe4FC+QiIMjqkq94QKpYA=;
        b=N0OijpHlS9ZaswLqjMNqSFLKS8TmbXrKgn0KxuuRM8aXSQz+C+UgQk87rXrEVbDVio
         e8Q9ReewOpIO7cPS/8aC1TD3Js3wBQKslURx/5VuFwAwY8kLKQhC/raR/0tQhOFIppyO
         BzE34TBvjVv5+s/0yDm9pDICNxW7OfwJACAKAy7swhalQE6H9QVfjKDqdCBCpLm7bUts
         NK7w0TF9j3oAk/rd1bDUxxfb85zHlNr46OIEpnPK4R0mvIe8shlNH0mYO0VS2BLgJTNW
         G2MllmdVjvc00favt/VWK+UFXbCD2volXSCwdcGYEMe2Gm7W0v+11PX6TZB7QBBYnrdo
         92HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715615329; x=1716220129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYQ0gjixSfurkzUiaxNduoPe4FC+QiIMjqkq94QKpYA=;
        b=Gne82huoZ5zsCeYNPYi+KyYnltyIkNBjYlTmr+u5XlEW9dxRRyi3Az/2AenpZfyNtA
         55VZUBLLerVCYOywV47lODd5r8L4W4Yb8i6swn6qyk7a2frETme8r6u5xzChtdveJi6x
         ijRAwRcSu9i15J7f81vK2/ySSzDziM1s9zLMNc5wdC05C//DQ02SWvSV+7CxG+8EHHHB
         jL690uVwyxL44/dBluzOMSdoxlKpXl02GPvNzC90rdgyjaGQG4pz1y/xk2rymudB90X3
         clpe6LI0thYOTR897qHe4rJefhIVLlq45Ln9+bzb6um6IHdIflDUtePTfkoKisXupj2l
         uxLg==
X-Forwarded-Encrypted: i=1; AJvYcCV6E1b0dt7ygm1qGtwXIVOVCsTvA+xxz2qJ+TxTROVHOTG9uPidae6iS3gxBJ9pJ9kgr1GRsgu2yRGp9V0zTtMeg6uW5QVMa7ULuDB9OC2c7Q==
X-Gm-Message-State: AOJu0Yzm0i0CAy+lQikc2M8nay8sp1uqThhZPRQK/kfQq+zuTg3YOrjw
	VwSELoDLr1c3ELWWeK8WhXjdFTwlKGNBVD46841aoo4Q8KbY6cm43R0CPFHpdame99HWMHZjb0v
	hG6jzHGhSqhdKwGsIFknxkJPhtd9BFpKrotsM
X-Google-Smtp-Source: AGHT+IHFPeUwje6u46qQGp/yl62ewYxSbg8BroLP1qrZakkaZuri3+FL8GC0Bmy0hAkLluYgzs5xr2jZm4ojRCLZVhU=
X-Received: by 2002:a17:903:298c:b0:1e9:4b4:907b with SMTP id
 d9443c01a7336-1f05f661701mr3954125ad.6.1715615328876; Mon, 13 May 2024
 08:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505031624.299361-1-irogers@google.com> <CAP-5=fVSAQOXbSfpSLTVkWcZKGx+LqiuC_ZkCxnc0iPtyfrzvQ@mail.gmail.com>
 <CAP-5=fXuneU6ockdzFcnLGqATKkEfvEuTa778Hj92rBmkbiS1w@mail.gmail.com> <34da7677-9c77-4efa-ae32-e0ef9a94013d@arm.com>
In-Reply-To: <34da7677-9c77-4efa-ae32-e0ef9a94013d@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 08:48:37 -0700
Message-ID: <CAP-5=fWwVNB0194npwSkW2RM0t0wYLrMKxTMXJAaquBZXRZjoA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
To: Robin Murphy <robin.murphy@arm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Stephane Eranian <eranian@google.com>, 
	Tuan Phan <tuanphan@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 7:35=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2024-05-10 8:15 pm, Ian Rogers wrote:
> > On Fri, May 10, 2024 at 11:13=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> >>
> >> On Sat, May 4, 2024 at 8:16=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> >>>
> >>> The mrvl_ddr_pmu is uncore and has a hexadecimal address
> >>> suffix. Current PMU sorting/merging code assumes uncore PMU names
> >>> start with uncore_ and have a decimal suffix. Add support for
> >>> hexadecimal suffixes and add tests.
> >>>
> >>> v3. Rebase and move tests from pmus.c to the existing pmu.c.
> >>>
> >>> Ian Rogers (2):
> >>>    perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
> >>>    perf tests: Add some pmu core functionality tests
> >>
> >> Hi, these patches have been hanging around since March [1], it would
> >> be nice to either be landing them or getting feedback on what to fix.
> >>
> >> Thanks,
> >> Ian
> >>
> >> [1] https://lore.kernel.org/lkml/20240329064803.3058900-1-irogers@goog=
le.com/
> >
> > +Tuan Phan, Robin Murphy
> >
> > Here is another PMU with the same suffix convention/issue:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/drivers/perf/arm_dmc620_pmu.c?h=3Dperf-tools-next#n706
>
> There are at least one or two more as well - certainly arm_smmuv3_pmu
> which I think may have been where this pattern first started. Now that
> we've finally done the right thing with the parent mechanism to provide
> a user-visible relationship of PMU instances to their corresponding
> Devicetree/ACPI devices, hopefully we can discourage any further use of
> this rather clunky trick of using the MMIO address as an identifier in
> the PMU name. However there's then also stuff like dwc_pcie_pmu which
> encodes a PCI ID as a hex suffix, so understanding hex suffixes in
> general might still be a reasonable idea for the tool, if the
> alternative would be maintaining a list of specific prefixes (even if
> that would be hoped to remain fairly small).

Thanks Robin, the problem that Kan identified was that IBM s390 have a
PMU called cpum_cf. So the _cf is a valid hex suffix. Maybe there
needs to be a minimum hex suffix length to deal with this. We made the
0x optional in perf "raw" events like `perf stat -e 'r12abcd'...` and
now we have the problem that the word `read` is both quite a desirable
perf event name and also a valid hex encoding. We prefer the event
name if it exists, but we have to make the code more complex to deal
with this. It would be nice if we were capturing the conventions in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/ABI/testing
Like with the sysfs-bus-event_source-* files. I'll do a v4 of these
changes and see if I can do something to document the suffixes, would
be great to get an Acked-by/Tested-by.

Thanks,
Ian

> Thanks,
> Robin.
