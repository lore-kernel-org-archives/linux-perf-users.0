Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298AA1D27A4;
	Tue,  6 Aug 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952208; cv=none; b=JiW04aAb5SOUHo+q0Nmn6L6gsmZ66OF745hQVlPxhX7SpATH+WHwgUx9538JxMkcsPecIFbSiLFtErAquA2IBI949CRp6bIopLxdBPw+Ngk9BccHJRlQtfITYIwTyx3/gCx590aKqtzfX2sgBBKnkAU42OLzZX2ylafe8/AGXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952208; c=relaxed/simple;
	bh=ViNFQZX1KF1hgpgV7zrHw49j/8aYGn1Bq6dW4VSWMQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkciAT78SPI/v1rZIUaMY6MIN6VfuHjZbTfVXXwVM/D+aeop/qUZaZ+9HEbY7v0+5Tos+8MLyEhog5PG4hcGTLDOCc7LXPtDbiOSuiPBEsMC2iHNAYtoImi5mx2/42oCvSfWzI27GyGyPrm6WDbb3hYqYZzkd5OTxsHSHg5AH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhZvdBoZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhZvdBoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF8AC32786;
	Tue,  6 Aug 2024 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722952207;
	bh=ViNFQZX1KF1hgpgV7zrHw49j/8aYGn1Bq6dW4VSWMQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhZvdBoZrlmlZpD01wdDp/IWpLtwBKX/SA9QtGZU9A8MTSXpgHAmxDVr5RxmMD9ZR
	 efw/I/gK/ELlECqGASEcUDUgXegxHJsPQrtU211cM6tK/lGd+j9f+LNG/DO0tmiYvR
	 0Cih9Gs+cEX8Rf8lfQjRFqEGQYNf9tKc6HvHOcQNtAg3nkinHVYSQ92RyHxuABfj0E
	 DWEhTjX9Z56jKtf6GNxwIGeoFPWvXAbBi42rdAEgY+NIRC7AhImGz0YPGnQTjy2HYT
	 6AqILYuQvu9QoLe4AZ7nuN5XSgq0zaHTaLA2k/mRNhhnl1McyTfJvN8ys8/KYC5b5+
	 5lcTx1P5JmtDw==
Date: Tue, 6 Aug 2024 10:50:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Eric Lin <eric.lin@sifive.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Ci-Jyun Wu <dminus@andestech.com>,
	Locus Wei-Han Chen <locus84@andestech.com>,
	Atish Patra <atishp@rivosinc.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, vincent.chen@sifive.com,
	greentime.hu@sifive.com
Subject: Re: [PATCH v1 4/5] perf pmu-events: Remove duplicated riscv firmware
 event
Message-ID: <ZrIqDMg7cBVhstYU@x1>
References: <20240805194424.597244-1-irogers@google.com>
 <20240805194424.597244-4-irogers@google.com>
 <CAPqJEFpiy307B4OBHK4WJGjgbVm_woUrdZ+Vy_LSdQ=ECqZX-Q@mail.gmail.com>
 <CAP-5=fWDmdAkJSoncedZTaSgFwG+p3--jywDj9krnXSfkhh6dQ@mail.gmail.com>
 <ZrInOywRKzRmjtKF@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrInOywRKzRmjtKF@x1>

On Tue, Aug 06, 2024 at 10:38:07AM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Aug 05, 2024 at 09:05:26PM -0700, Ian Rogers wrote:
> > On Mon, Aug 5, 2024 at 8:54 PM Eric Lin <eric.lin@sifive.com> wrote:
> > > I've sent a patch to fix it and the patch already merged. Thanks.
> > > https://lore.kernel.org/all/20240719115018.27356-1-eric.lin@sifive.com/

> > Right, I already commented this should have gone through the
> > perf-tools-next tree:
> > https://lore.kernel.org/all/CAP-5=fV3NXkKsCP1WH0_qLRNpL+WuP8S3h1=cHaUMH5MFkVHQg@mail.gmail.com/
> > Arnaldo, please take Eric's patch in preference to this one.

> So I removed your version from perf-tools-next, eventually we'll get
> this merged upstream, I'm just checking this isn't going to get in our
> way of testing what we have in perf-tools-next...

As expected:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
<SNIP>
make_no_libdw_dwarf_unwind_O: cd . && make NO_LIBDW_DWARF_UNWIND=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.1xBTPCPJh1 DESTDIR=/tmp/tmp.6upZRBhUpN
          make_jevents_all_O: cd . && make JEVENTS_ARCH=all FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.ncjKsS9Ddm DESTDIR=/tmp/tmp.z2lxV44jzL
cd . && make JEVENTS_ARCH=all FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.ncjKsS9Ddm DESTDIR=/tmp/tmp.z2lxV44jzL
  BUILD:   Doing 'make -j28' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
<SNIP>
  LD      /tmp/tmp.ncjKsS9Ddm/util/perf-util-in.o
  LD      /tmp/tmp.ncjKsS9Ddm/perf-util-in.o
  AR      /tmp/tmp.ncjKsS9Ddm/libperf-util.a
Traceback (most recent call last):
  File "/home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py", line 1317, in <module>
    main()
  File "/home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py", line 1308, in main
    ftw(arch_path, [], process_one_file)
  File "/home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py", line 1245, in ftw
    ftw(item.path, parents + [item.name], action)
  File "/home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py", line 1243, in ftw
    action(parents, item)
  File "/home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py", line 646, in process_one_file
    print_pending_events()
  File "/home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py", line 510, in print_pending_events
    assert event.name != last_name, f"Duplicate event: {last_pmu}/{last_name}/ in {_pending_events_tblname}"
           ^^^^^^^^^^^^^^^^^^^^^^^
AssertionError: Duplicate event: default_core/fw_sfence_vma_received/ in pmu_events__andes_ax45
make[5]: *** [pmu-events/Build:46: /tmp/tmp.ncjKsS9Ddm/pmu-events/pmu-events.c] Error 1
make[5]: *** Deleting file '/tmp/tmp.ncjKsS9Ddm/pmu-events/pmu-events.c'
make[4]: *** [Makefile.perf:763: /tmp/tmp.ncjKsS9Ddm/pmu-events/pmu-events-in.o] Error 2

So I'll have to cherry pick that patch and have it in perf-tools-next,
we'll get notified at some point that linux-next has the same patch,
will ack that, etc.

Please send patches for this area in the future to the perf-tools-next
tree.

- Arnaldo
