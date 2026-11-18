Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037225;
	b=CoUz0hSldS3MliXsMKFfydM76d5oMD1BPlOas9x5CJvbfsCbgEt1I8vch86kUm/FIvWi
	 jVqyCYWh95VWVGtu9Oc3kl/BhXORi+r6LvK+tubxnMnJMYIpRzGvF1Q7R9ZPSCDA0j2C3
	 8G332V7aJ4BX7rd+uKmCnPFBdAlr2jOiwC1d3T5Fs520ORugnVqUDc2wbELrZpPLsVKew
	 HxbI+Y/wxNpQMTEZ/PL/RdSslQnUY+PgCxN0qZ+QjubTER+Jjfd9G7TrJbC6yuTACx0lS
	 WwIE0J7XjUjRHsio/zg5xQmNMVpsooO4RWmT64J3qJFjZiKDxEWqSIb1772eXVD81eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ahm1QyeaoerL3tZ6F771LHuvYp9jeT38zbnLSZrK1Fk=;
	b=i3tlCqTUYPjMf6JBExsmHpkI1m+4U5EEX8Y1633Hgik1l6Gsa0pM65Rdt3TW1HwcGMaW
	 ewuwdgKAoUx0fXyOjrUh2X18tqeJctF3UxCTm0UdKNiQmU7hRSPlPJYpbJA3Z4SWKBmTE
	 bMo9n4dqV++g53xLkut1Mc38UEyC+8k/eyV9/ip9N9e7WLYoUw7VkwuVyQ2CoCcALf3mv
	 29TkDStuoSmka9gzjzl28oKi7KM2uggxeAoRx/eGtDG5dhNSOUCCVZTU2Da43dqxWiSIk
	 CjHT/R/fdV/Tl7/i7jnR/DlP45fW6+wsoSPLIY0NArUeAxONnOWT5bIMIO6/vBrFncw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ma6y7rkz;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31D606A33E
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 21:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA31D606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ma6y7rkz
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-5641cd2cc13so1590121b6e.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 13:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795037221; x=1795642021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ahm1QyeaoerL3tZ6F771LHuvYp9jeT38zbnLSZrK1Fk=;
        b=ma6y7rkzAKs1jL7mRGuTawJ8M7npwzuxeFR4ZFVvwcfNgO+oAj6v2lTDasvePBLFqJ
         tBHld6ETF7P+Dx07bad7qQA+3h/Lf7dw7Y1uFXcyxrr5JJ/pkFWpZuUg1cUzPkeCaS9v
         6b1IJXKI7LA4qkFnK5xd1+K31+7fXVL0IbusyPnxjNgUxuXLerxh0hd1m4D+izl5cSfU
         l1XyeD2eflgYM/unxV7jo2zfUG38lwvDs6z0BiHOf4Vu+b0xPHeX5Dr9P6Y94gTgk5G/
         EnzN/eqVcDpvMu/qE/yA794T0r5o99nD+WB8VU62t6Gg3D5WOhYM5BSEdaP1a27HCWua
         5Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037221; x=1795642021;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ahm1QyeaoerL3tZ6F771LHuvYp9jeT38zbnLSZrK1Fk=;
        b=Clwdl/gWdiT99dCdTAKjNzBTdeshyluf/PXZbsNrpJngjDMHIV8EUn2R948AQPj3x0
         8bOv3/amiSHUegpKIlnPJ9D0KVPxMk+AgMqV+HHXIkokIhI7H3X7SK77qk372cDWjIR/
         JrgZm4IaNOaQPlxhlv3kYnON6NzQRjgZFZ98ll+SQ8DUe5RBd6CXgBh0XiZFaIumNv2Y
         o4TJvZhV2yg4ODc1h8ymO19KM/Mg19tmOecWXR/OWdCLKgUfe5AhhzsqLAHErMdmcAPz
         qiKju5QKgTUxI/fvxwc7M6k8EFvLbZDAw/aIjvl238/+duXtryQt6TbXr28CdEQCcEko
         77wA==
X-Forwarded-Encrypted: i=1; AL+hErHKEQeuPlkZoYktQcJ+ZcjF4oBFXDBxP3VsWUWqCKEWXWXxMUrbZK2d0DbKGWQ/F8tQbbepvgTxDTwhyKOwoUh+@vger.kernel.org
X-Gm-Message-State: APuU4Z+IrqMQpvDmKMk589wJw9aYHBr/a9FepE8tT3ebk9lP5WDq6iJF
	tu5NL4jr9Wb38oqMYKDn4l/JgQTLrR25uaX9NAWCTECjPXgbJVRUYH6Eg2zdPwFaYXTJ9SrVZ6q
	MUNAOGQ==
X-Received: from ioi4-n2.prod.google.com ([2002:a05:6602:c644:20b0:9c7:6dd9:edb5])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6809:18:10b0:557:30d7:f40e
 with SMTP id 5614622812f47-5774660b2f0mr2948283b6e.53.1795037219899; Wed, 18
 Nov 2026 13:26:59 -0800 (PST)
Date: Wed, 18 Nov 2026 13:26:53 -0800
In-Reply-To: <20261118212655.2262601-1-ctshao@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118212655.2262601-1-ctshao@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118212655.2262601-2-ctshao@google.com>
Subject: [PATCH v1 1/3] perf vendor events intel: Add diamondrapids v1.00 events
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/f7483a9ec07e8dcaae9b94be01d7660dfff=
a5f55
https://github.com/intel/perfmon/commit/6b00a2493aaf37861a70cd9c35544b4d676=
dcdbf

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-4-carbon
---
 .../arch/x86/diamondrapids/cache.json         |  952 +++++++++++
 .../arch/x86/diamondrapids/counter.json       |   52 +
 .../x86/diamondrapids/floating-point.json     |  419 +++++
 .../arch/x86/diamondrapids/frontend.json      |  458 ++++++
 .../arch/x86/diamondrapids/memory.json        |  295 ++++
 .../arch/x86/diamondrapids/other.json         |  777 +++++++++
 .../arch/x86/diamondrapids/pipeline.json      | 1423 +++++++++++++++++
 .../arch/x86/diamondrapids/uncore-cache.json  |  292 ++++
 .../arch/x86/diamondrapids/uncore-cxl.json    |   22 +
 .../diamondrapids/uncore-interconnect.json    |  218 +++
 .../arch/x86/diamondrapids/uncore-io.json     |  386 +++++
 .../arch/x86/diamondrapids/uncore-memory.json |  939 +++++++++++
 .../x86/diamondrapids/virtual-memory.json     |  266 +++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    1 +
 14 files changed, 6500 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/counter.js=
on
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/floating-p=
oint.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/frontend.j=
son
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/memory.jso=
n
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/pipeline.j=
son
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cac=
he.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cxl=
.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-int=
erconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-io.=
json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-mem=
ory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/virtual-me=
mory.json

diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/cache.json b/tool=
s/perf/pmu-events/arch/x86/diamondrapids/cache.json
new file mode 100644
index 000000000000..83b6e7c733c5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/cache.json
@@ -0,0 +1,952 @@
+[
+    {
+        "BriefDescription": "Counts the number of cache lines replaced in =
L0 data cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x51",
+        "EventName": "L1D.L0_REPLACEMENT",
+        "PublicDescription": "Counts L0 data line replacements including o=
pportunistic replacements, and replacements that require stall-for-replace =
or block-for-replace.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cachelines replaced into the L1 d-cache. Succ=
essful replacements only (not blocked) and exclude WB-miss case",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x51",
+        "EventName": "L1D.L1_REPLACEMENT",
+        "PublicDescription": "Counts cachelines replaced into the L1 d-cac=
he.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "This event is deprecated.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0x51",
+        "EventName": "L1D.REPLACEMENT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Number of cycles a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "L1D_MISS.FB_FULL",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x49",
+        "EventName": "L1D_MISS.FB_FULL_PERIODS",
+        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of cycles a demand request has waited =
due to L1D due to lack of L2 resources.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "L1D_MISS.L2_STALLS",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of demand requests that missed L1D cac=
he",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "L1D_MISS.LOAD",
+        "PublicDescription": "Count occurrences (rising-edge) of DCACHE_PE=
NDING sub-event0. Impl. sends per-port binary inc-bit the occupancy increas=
es* (at FB alloc or promotion).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of L1D misses that are outstanding",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x48",
+        "EventName": "L1D_PENDING.LOAD",
+        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles with L1D load Misses outstanding.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x48",
+        "EventName": "L1D_PENDING.LOAD_CYCLES",
+        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "L2 cache lines filling L2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.ALL",
+        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x3f"
+    },
+    {
+        "BriefDescription": "Modified cache lines that are evicted by L2 c=
ache when triggered by an L2 cache fill.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.NON_SILENT",
+        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.SILENT",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cache lines that have been L2 hardware prefet=
ched but not used by demand accesses",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.USELESS_HWPF",
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_RQSTS.REFERENCES, L2_RQSTS.ANY]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES, L2_RQSTS.ANY]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "L2 code requests [This event is alias to L2_R=
QSTS.ALL_CODE_RD]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL_CODE_RD",
+        "PublicDescription": "Counts the total number of L2 code requests.=
 [This event is alias to L2_RQSTS.ALL_CODE_RD]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4"
+    },
+    {
+        "BriefDescription": "Demand Data Read access L2 cache [This event =
is alias to L2_RQSTS.ALL_DEMAND_DATA_RD]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL_DEMAND_DATA_RD",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once. [Th=
is event is alias to L2_RQSTS.ALL_DEMAND_DATA_RD]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe1"
+    },
+    {
+        "BriefDescription": "RFO requests to L2 cache [This event is alias=
 to L2_RQSTS.ALL_RFO]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL_RFO",
+        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches. [This event is alias to L2_RQSTS.ALL_R=
FO]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe2"
+    },
+    {
+        "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads. [This event is alias to L2_RQSTS.CODE_RD_HIT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.CODE_RD_HIT",
+        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads. [This event is alias to L2_RQSTS.CODE_RD_HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x44"
+    },
+    {
+        "BriefDescription": "L2 cache misses when fetching instructions [T=
his event is alias to L2_RQSTS.CODE_RD_MISS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.CODE_RD_MISS",
+        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions. [This event is alias to L2_RQSTS.CODE_RD_MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x24"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests that hit L2 cache [=
This event is alias to L2_RQSTS.DEMAND_DATA_RD_HIT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_DATA_RD_HIT",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache. [This event is alias t=
o L2_RQSTS.DEMAND_DATA_RD_HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Demand Data Read miss L2 cache [This event is=
 alias to L2_RQSTS.DEMAND_DATA_RD_MISS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_DATA_RD_MISS",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once. [This event is alias to L2_RQSTS.DE=
MAND_DATA_RD_MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event i=
s alias to L2_RQSTS.HIT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This=
 event is alias to L2_RQSTS.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x5f"
+    },
+    {
+        "BriefDescription": "Read requests with true-miss in L2 cache [Thi=
s event is alias to L2_RQSTS.MISS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3f"
+    },
+    {
+        "BriefDescription": "RFO requests that hit L2 cache [This event is=
 alias to L2_RQSTS.RFO_HIT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.RFO_HIT",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache. [This event is alias to L2_RQSTS.RFO_HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x42"
+    },
+    {
+        "BriefDescription": "L2_REQUEST.RFO_HIT_XSNP_HIT_FWD [This event i=
s alias to L2_RQSTS.RFO_HIT_XSNP_HIT_FWD]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.RFO_HIT_XSNP_HIT_FWD",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2002"
+    },
+    {
+        "BriefDescription": "RFO requests that miss L2 cache [This event i=
s alias to L2_RQSTS.RFO_MISS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.RFO_MISS",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache. [This event is alias to L2_RQSTS.RFO_MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x22"
+    },
+    {
+        "BriefDescription": "SW prefetch requests that hit L2 cache. [This=
 event is alias to L2_RQSTS.SWPF_HIT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.SWPF_HIT",
+        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full. [This event is alias to L2_RQSTS.SWPF_HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x48"
+    },
+    {
+        "BriefDescription": "SW prefetch requests that miss L2 cache. [Thi=
s event is alias to L2_RQSTS.SWPF_MISS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.SWPF_MISS",
+        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full. [This event is alias to L2_RQSTS.SWPF_MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x28"
+    },
+    {
+        "BriefDescription": "L2 code requests [This event is alias to L2_R=
EQUEST.ALL_CODE_RD]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_CODE_RD",
+        "PublicDescription": "Counts the total number of L2 code requests.=
 [This event is alias to L2_REQUEST.ALL_CODE_RD]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4"
+    },
+    {
+        "BriefDescription": "Demand Data Read access L2 cache [This event =
is alias to L2_REQUEST.ALL_DEMAND_DATA_RD]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once. [Th=
is event is alias to L2_REQUEST.ALL_DEMAND_DATA_RD]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe1"
+    },
+    {
+        "BriefDescription": "RFO requests to L2 cache [This event is alias=
 to L2_REQUEST.ALL_RFO]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_RFO",
+        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches. [This event is alias to L2_REQUEST.ALL=
_RFO]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe2"
+    },
+    {
+        "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_RQSTS.REFERENCES, L2_REQUEST.ALL]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ANY",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES, L2_REQUEST.ALL]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads. [This event is alias to L2_REQUEST.CODE_RD_HIT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.CODE_RD_HIT",
+        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads. [This event is alias to L2_REQUEST.CODE_RD_HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x44"
+    },
+    {
+        "BriefDescription": "L2 cache misses when fetching instructions [T=
his event is alias to L2_REQUEST.CODE_RD_MISS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.CODE_RD_MISS",
+        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions. [This event is alias to L2_REQUEST.CODE_RD_MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x24"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests that hit L2 cache [=
This event is alias to L2_REQUEST.DEMAND_DATA_RD_HIT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache. [This event is alias t=
o L2_REQUEST.DEMAND_DATA_RD_HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Demand Data Read miss L2 cache [This event is=
 alias to L2_REQUEST.DEMAND_DATA_RD_MISS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once. [This event is alias to L2_REQUEST.=
DEMAND_DATA_RD_MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event i=
s alias to L2_REQUEST.HIT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This=
 event is alias to L2_REQUEST.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x5f"
+    },
+    {
+        "BriefDescription": "Read requests with true-miss in L2 cache [Thi=
s event is alias to L2_REQUEST.MISS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.MISS",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3f"
+    },
+    {
+        "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_REQUEST.ALL,L2_RQSTS.ANY]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.REFERENCES",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL,L2_RQSTS.ANY]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "RFO requests that hit L2 cache [This event is=
 alias to L2_REQUEST.RFO_HIT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_HIT",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache. [This event is alias to L2_REQUEST.RFO_HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x42"
+    },
+    {
+        "BriefDescription": "L2_RQSTS.RFO_HIT_XSNP_HIT_FWD [This event is =
alias to L2_REQUEST.RFO_HIT_XSNP_HIT_FWD]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_HIT_XSNP_HIT_FWD",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2002"
+    },
+    {
+        "BriefDescription": "RFO requests that miss L2 cache [This event i=
s alias to L2_REQUEST.RFO_MISS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_MISS",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache. [This event is alias to L2_REQUEST.RFO_MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x22"
+    },
+    {
+        "BriefDescription": "SW prefetch requests that hit L2 cache. [This=
 event is alias to L2_REQUEST.SWPF_HIT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.SWPF_HIT",
+        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full. [This event is alias to L2_REQUEST.SWPF_HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x48"
+    },
+    {
+        "BriefDescription": "SW prefetch requests that miss L2 cache. [Thi=
s event is alias to L2_REQUEST.SWPF_MISS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.SWPF_MISS",
+        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full. [This event is alias to L2_REQUEST.SWPF_MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x28"
+    },
+    {
+        "BriefDescription": "L1D writebacks that access L2 cache",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x23",
+        "EventName": "L2_TRANS.L1D_WB",
+        "PublicDescription": "This event counts L1D writebacks that access=
 L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Cycles when L1D is locked",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x42",
+        "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
+        "PublicDescription": "This event counts the number of cycles when =
the L1D is locked.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4f"
+    },
+    {
+        "BriefDescription": "Counts all retired load instructions.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
+        "PublicDescription": "Counts Instructions with at least one archit=
ecturally visible load retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81"
+    },
+    {
+        "BriefDescription": "Retired store instructions.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_STORES",
+        "PublicDescription": "Counts all retired store instructions. Avail=
able PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82"
+    },
+    {
+        "BriefDescription": "Retired software prefetch instructions.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_SWPF",
+        "PublicDescription": "Counts all retired software prefetch instruc=
tions. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x84"
+    },
+    {
+        "BriefDescription": "All retired memory instructions.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ANY",
+        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x87"
+    },
+    {
+        "BriefDescription": "Retired load instructions with locked access.=
",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
+        "PublicDescription": "Counts retired load instructions with locked=
 access. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Retired load instructions that split across a=
 cacheline boundary.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
+        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Retired store instructions that split across =
a cacheline boundary.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
+        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x42"
+    },
+    {
+        "BriefDescription": "Retired load instructions that hit the STLB."=
,
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_LOADS",
+        "PublicDescription": "Number of retired load instructions with a c=
lean hit in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "Retired store instructions that hit the STLB.=
",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_STORES",
+        "PublicDescription": "Number of retired store instructions that hi=
t in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0xa"
+    },
+    {
+        "BriefDescription": "Retired load instructions that miss the STLB.=
",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
+        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Retired store instructions that miss the STLB=
.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
+        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x12"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.CACHE_HIT_OTHER_CBB_=
LOCAL_SOCKET",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.CACHE_HIT_OTHER_CBB_LOCAL_S=
OCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFD006000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.CACHE_HIT_OTHER_CBB=
_LOCAL_SOCKET Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.CACHE_HIT_REMOTE_SOC=
KET",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.CACHE_HIT_REMOTE_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFE007000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.CACHE_HIT_REMOTE_SO=
CKET Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HITESF.S=
NP_HIT_NO_FWD",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HITESF.SNP_HIT_=
NO_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x45000400000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HITESF.=
SNP_HIT_NO_FWD Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HITESF.S=
NP_MISS",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HITESF.SNP_MISS=
",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x25000400000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HITESF.=
SNP_MISS Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xED000400000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB Ava=
ilable PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB_SNP_=
HIT_NO_FWD",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB_SNP_HIT_NO_=
FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4D000400000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB_SNP=
_HIT_NO_FWD Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_MISS",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.L3_MISS",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFFFFF000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.L3_MISS Available P=
DIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_0",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_0",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5010000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_0 Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_1",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_1",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5020000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_1 Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_2",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5040000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_2 Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_3",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_3",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5080000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_3 Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_4",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_4",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5100000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_4 Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_5",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_5",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5200000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_5 Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_6",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_6",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5400000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_6 Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_7",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_7",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5800000000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.MEM_REGION_7 Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.OTHER_MODULE_L2.SAME=
_CBB.HITM.SNP_FWD",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.OTHER_MODULE_L2.SAME_CBB.HI=
TM.SNP_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x89000800000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.OTHER_MODULE_L2.SAM=
E_CBB.HITM.SNP_FWD Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.OTHER_MODULE_L2_HIT_=
SAME_CBB",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xD6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.OTHER_MODULE_L2_HIT_SAME_CB=
B",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xCD000800000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.OTHER_MODULE_L2_HIT=
_SAME_CBB Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_LOAD_L2_MISS_RETIRED.OTHER_MODULE_L2_HIT_=
SAME_CBB_SNP_FWD",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd6",
+        "EventName": "MEM_LOAD_L2_MISS_RETIRED.OTHER_MODULE_L2_HIT_SAME_CB=
B_SNP_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x8D000800000001",
+        "PublicDescription": "MEM_LOAD_L2_MISS_RETIRED.OTHER_MODULE_L2_HIT=
_SAME_CBB_SNP_FWD Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or lock.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_MISC_RETIRED.UC",
+        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of completed demand load requests that=
 missed the L1, but hit the FB(fill buffer), because a preceding miss to th=
e same cacheline initiated the line to be brought into L1, but data is not =
yet ready in L1.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.FB_HIT",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready. Available PDIST counters:=
 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L1 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source. Available PDIST c=
ounters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts retired load instructions with at leas=
t one uop that hit in the Level 0 of the L1 data cache. This event includes=
 all SW prefetches and lock instructions regardless of the data source.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT_L0",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 0 of the L1 data cache. This event include=
s all SW prefetches and lock instructions regardless of the data source. Av=
ailable PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts retired load instructions with at leas=
t one uop that hit in the Level 1 of the L1 data cache.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT_L1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 1 of the L1 data cache. Available PDIST co=
unters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L1 cache as =
data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_MISS",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Retired instruction with at least 1 load uop =
whose Data Source was: Hit in L2 cache in a local slice of MLC of DCM.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_HIT_LOCAL",
+        "PublicDescription": "Retired instruction with at least 1 load uop=
 whose Data Source was: Hit in L2 cache in a local slice of MLC of DCM. Ava=
ilable PDIST counters: 0,1",
+        "SampleAfterValue": "50021",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L2 cache as =
data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_MISS",
+        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x8000"
+    },
+    {
+        "BriefDescription": "Retired instruction with at least 1 load uop =
whose Data Source was: Hit in L2 cache that required a snoop to other core =
in DCM - data was forwarded from other core.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_XSNP_HIT_FWD",
+        "PublicDescription": "Retired instruction with at least 1 load uop=
 whose Data Source was: Hit in L2 cache that required a snoop to other core=
 in DCM - data was forwarded from other core. Available PDIST counters: 0,1=
",
+        "SampleAfterValue": "50021",
+        "UMask": "0x200"
+    },
+    {
+        "BriefDescription": "Retired instruction with at least 1 load uop =
whose Data Source was: Hit in L2 cache that required a snoop to other core =
in DCM which missed the other core and no data was forwarded.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_XSNP_MISS",
+        "PublicDescription": "Retired instruction with at least 1 load uop=
 whose Data Source was: Hit in L2 cache that required a snoop to other core=
 in DCM which missed the other core and no data was forwarded. Available PD=
IST counters: 0,1",
+        "SampleAfterValue": "50021",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "MEM_STORE_L2_MISS_RETIRED.CACHE_HITM_OTHER_CB=
B_ANY_SOCKET",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4F",
+        "EventName": "MEM_STORE_L2_MISS_RETIRED.CACHE_HITM_OTHER_CBB_ANY_S=
OCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFB006000000002",
+        "PublicDescription": "MEM_STORE_L2_MISS_RETIRED.CACHE_HITM_OTHER_C=
BB_ANY_SOCKET Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_STORE_L2_MISS_RETIRED.OTHER_MODULE_L2.SAM=
E_CBB.HITM.SNP_FWD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4F",
+        "EventName": "MEM_STORE_L2_MISS_RETIRED.OTHER_MODULE_L2.SAME_CBB.H=
ITM.SNP_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x89000800000002",
+        "PublicDescription": "MEM_STORE_L2_MISS_RETIRED.OTHER_MODULE_L2.SA=
ME_CBB.HITM.SNP_FWD Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "MEM_STORE_RETIRED.L2_HIT_LOCAL",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x44",
+        "EventName": "MEM_STORE_RETIRED.L2_HIT_LOCAL",
+        "SampleAfterValue": "200003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Retired memory uops for any access",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe5",
+        "EventName": "MEM_UOP_RETIRED.ANY",
+        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xf"
+    },
+    {
+        "BriefDescription": "Counts bus locks, accounts for cache line spl=
it locks and UC locks.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2c",
+        "EventName": "SQ_MISC.BUS_LOCK",
+        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
+        "SampleAfterValue": "503",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of PREFETCHNTA, PREFETCHW, =
PREFETCHT0, PREFETCHT1 or PREFETCHT2 instructions executed.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.ANY",
+        "SampleAfterValue": "100003",
+        "UMask": "0xf"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.NTA",
+        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHW instructions executed.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
+        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T0",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructio=
ns executed.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/counter.json b/to=
ols/perf/pmu-events/arch/x86/diamondrapids/counter.json
new file mode 100644
index 000000000000..bde10331719a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/counter.json
@@ -0,0 +1,52 @@
+[
+    {
+        "Unit": "core",
+        "CountersNumFixed": "4",
+        "CountersNumGeneric": "8"
+    },
+    {
+        "Unit": "IMC",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "8"
+    },
+    {
+        "Unit": "HAMVF",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "CBOX",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "SCA",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "CXLCM",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "8"
+    },
+    {
+        "Unit": "UBR",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "OTC",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "ITC",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "ULA",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/floating-point.js=
on b/tools/perf/pmu-events/arch/x86/diamondrapids/floating-point.json
new file mode 100644
index 000000000000..71e06fba4147
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/floating-point.json
@@ -0,0 +1,419 @@
+[
+    {
+        "BriefDescription": "Cycles when floating-point divide unit is bus=
y executing divide or square root operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.FPDIV_ACTIVE",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for floating-point operatio=
ns only.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event counts the number of floating-poin=
t divide instructions executed this cycle. 512-bits divide/SQRT are counted=
 as 1.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.FPDIV_INST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts all microcode FP assists.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.FP",
+        "PublicDescription": "Counts all microcode Floating Point assists.=
",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "ASSISTS.SSE_AVX_MIX",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.SSE_AVX_MIX",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V0",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V0",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V2",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V3",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V4",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "FP_ARITH_DISPATCHED.V5",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V5",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 128-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice =
as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 SQRT =
DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they pe=
rform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed single =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14=
 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform =
2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14=
 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calc=
ulations per element. The DAZ and FTZ flags in the MXCSR register need to b=
e set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 16 computatio=
n operations, one for each element.  Applies to SSE* and AVX* packed single=
 precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT1=
4 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform=
 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 16 computation oper=
ations, one for each element.  Applies to SSE* and AVX* packed single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP1=
4 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 cal=
culations per element. The DAZ and FTZ flags in the MXCSR register need to =
be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational scalar=
 double precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar double precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructi=
ons count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "FP_ARITH_INST_RETIRED.SCALAR_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x100"
+    },
+    {
+        "BriefDescription": "Number of all Scalar Half-Precision FP arithm=
etic instructions(1) retired - regular and complex.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_HALF_WCOMPLEX",
+        "SampleAfterValue": "100003",
+        "UMask": "0x300"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational scalar=
 single precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar single precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB=
 instructions count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "FP_ARITH_INST_RETIRED.VECTOR_128B",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.VECTOR_128B",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40c"
+    },
+    {
+        "BriefDescription": "FP_ARITH_INST_RETIRED.VECTOR_256B",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.VECTOR_256B",
+        "SampleAfterValue": "100003",
+        "UMask": "0x830"
+    },
+    {
+        "BriefDescription": "FP_ARITH_INST_RETIRED.VECTOR_512B",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_ARITH_INST_RETIRED.VECTOR_512B",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10c0"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 128-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice =
as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.128B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.128B_PACKED_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.128B_PACKED_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x400"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 SQRT =
DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they pe=
rform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.128B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.16_FLOPS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.16_FLOPS",
+        "SampleAfterValue": "100003",
+        "UMask": "0x880"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.1_FLOPS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.1_FLOPS",
+        "SampleAfterValue": "100003",
+        "UMask": "0x103"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.256B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.256B_PACKED_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.256B_PACKED_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x800"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed single =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.256B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.2_FLOPS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.2_FLOPS",
+        "SampleAfterValue": "100003",
+        "UMask": "0x204"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.32_FLOPS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.32_FLOPS",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1000"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single and 256-bit packed double precision FP instructions retired; some =
instructions will count twice as noted below.  Each count represents 2 or/a=
nd 4 computation operations, 1 for each element.  Applies to SSE* and AVX* =
packed single precision and packed double precision FP instructions: ADD SU=
B HADD HSUB SUBADD MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DP=
P and FM(N)ADD/SUB count twice as they perform 2 calculations per element."=
,
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.4_FLOPS",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events."=
,
+        "SampleAfterValue": "100003",
+        "UMask": "0x18"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14=
 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform =
2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.512B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14=
 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calc=
ulations per element. The DAZ and FTZ flags in the MXCSR register need to b=
e set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.512B_PACKED_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.512B_PACKED_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1000"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 16 computatio=
n operations, one for each element.  Applies to SSE* and AVX* packed single=
 precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT1=
4 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform=
 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.512B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 16 computation oper=
ations, one for each element.  Applies to SSE* and AVX* packed single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP1=
4 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 cal=
culations per element. The DAZ and FTZ flags in the MXCSR register need to =
be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d single precision and 512-bit packed double precision  FP instructions ret=
ired; some instructions will count twice as noted below.  Each count repres=
ents 8 computation operations, 1 for each element.  Applies to SSE* and AVX=
* packed single precision and double precision FP instructions: ADD SUB HAD=
D HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14 RCP RCP14 DPP FM(N)ADD/SUB=
.  DPP and FM(N)ADD/SUB count twice as they perform 2 calculations per elem=
ent.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.8_FLOPS",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision and 512-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 8 computation operations, one for each element.  Applies =
to SSE* and AVX* packed single precision and double precision floating-poin=
t instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14=
 RCP RCP14 DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice=
 as they perform 2 calculations per element. The DAZ and FTZ flags in the M=
XCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x460"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.COMPLEX_SCALAR_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.COMPLEX_SCALAR_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x200"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired; some instructions will count twice as noted =
below.  Applies to SSE* and AVX* scalar, double and single precision floati=
ng-point: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 RANGE SQRT DPP FM(N)ADD/SUB=
.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple c=
alculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.SCALAR",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x303"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational scalar=
 double precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar double precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructi=
ons count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.SCALAR_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.SCALAR_HALF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.SCALAR_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x100"
+    },
+    {
+        "BriefDescription": "Number of all Scalar Half-Precision FP arithm=
etic instructions(1) retired - regular and complex.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.SCALAR_HALF_WCOMPLEX",
+        "PublicDescription": "FP_ARITH_OPS_RETIRED.SCALAR_HALF_WCOMPLEX",
+        "SampleAfterValue": "100003",
+        "UMask": "0x300"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational scalar=
 single precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar single precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB=
 instructions count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.SCALAR_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of any Vector retired FP arithmetic in=
structions",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.VECTOR",
+        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1cfc"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.VECTOR_128B",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.VECTOR_128B",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40c"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.VECTOR_256B",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.VECTOR_256B",
+        "SampleAfterValue": "100003",
+        "UMask": "0x830"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.VECTOR_512B",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.VECTOR_512B",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10c0"
+    },
+    {
+        "BriefDescription": "Number of all Vector (also called packed) Hal=
f-Precision FP arithmetic instructions(1) retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.VECTOR_HALF",
+        "PublicDescription": "FP_ARITH_OPS_RETIRED.VECTOR_HALF",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1c00"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/frontend.json b/t=
ools/perf/pmu-events/arch/x86/diamondrapids/frontend.json
new file mode 100644
index 000000000000..5b83d500be57
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/frontend.json
@@ -0,0 +1,458 @@
+[
+    {
+        "BriefDescription": "Clears due to Unknown Branches.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x60",
+        "EventName": "BACLEARS.ANY",
+        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x87",
+        "EventName": "DECODE.LCP",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles the Microcode Sequencer is busy.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x87",
+        "EventName": "DECODE.MS_BUSY",
+        "SampleAfterValue": "500009",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x61",
+        "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired ANT branches",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ANY_ANT",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x9",
+        "PublicDescription": "Always Not Taken (ANT) conditional retired b=
ranches (no BTB entry and not mispredicted) Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced DSB miss=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x1",
+        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss. Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x11",
+        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced iTLB tru=
e miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ITLB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x14",
+        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced Instruct=
ion L1 Cache true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.L1I_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x12",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced Instruct=
ion L2 Cache true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.L2_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x13",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions after front-end starvati=
on of at least 1 cycle",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600106",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall. Available PDIST coun=
ters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 128 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x608006",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 16 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x601006",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions after front-end starvati=
on of at least 2 cycles",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600206",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 256 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x610006",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end had at least 1 bubble-slot for a period of 2=
 cycles which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x100206",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 32 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x602006",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 4 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600406",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall. Available PDIST count=
ers: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 512 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x620006",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 64 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x604006",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall. Available PDIST coun=
ters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 8 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600806",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "I-Cache miss too close to Code Prefetch Instr=
uction",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATE_SWPF",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x1A",
+        "PublicDescription": "Number of Instruction Cache demand miss in s=
hadow of an on-going i-fetch cache-line triggered by PREFETCHIT0/1 instruct=
ions Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Mispredicted Retired ANT branches",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.MISP_ANT",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x9",
+        "PublicDescription": "ANT retired branches that got just mispredic=
ted Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts flows delivered by the Microcode Seque=
ncer",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.MS_FLOWS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "PublicDescription": "Counts flows delivered by the Microcode Sequ=
encer Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.STLB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x15",
+        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired instructions that caused clears due t=
o being Unknown Branches.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x17",
+        "PublicDescription": "Number retired branch instructions that caus=
ed the front-end to be resteered when it finds the instruction in a fetch l=
ine. This is called Unknown Branch which occurs for the first time a branch=
 instruction is fetched or when the branch is not tracked by the BPU (Branc=
h Prediction Unit) anymore. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALLS",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "ICACHE_DATA.STALL_PERIODS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALL_PERIODS",
+        "SampleAfterValue": "500009",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache In use-full",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS_INUSE",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache ISB-full",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS_ISB",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_ANY",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles DSB is delivering optimal number of Uo=
ps",
+        "Counter": "0,1,2,3",
+        "CounterMask": "8",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_OK",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_UOPS",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles MITE is delivering any Uop",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_CYCLES_ANY",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles MITE is delivering optimal number of U=
ops",
+        "Counter": "0,1,2,3",
+        "CounterMask": "8",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_CYCLES_OK",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_UOPS",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles when uops are being delivered to IDQ w=
hile MS is busy",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_CYCLES_ANY",
+        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Number of switches from DSB or MITE to the MS=
",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_SWITCHES",
+        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Uops initiated by MITE or Decode Stream Buffe=
r (DSB) and delivered to Instruction Decode Queue (IDQ) while Microcode Seq=
uencer (MS) is busy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_UOPS",
+        "PublicDescription": "Counts the number of uops initiated by MITE =
or Decode Stream Buffer (DSB) and delivered to Instruction Decode Queue (ID=
Q) while the Microcode Sequencer (MS) is busy. Counting includes uops that =
may 'bypass' the IDQ.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "count cycles when IDQ didn't deliver any uop =
for 1 cycle, counts 1-cycle starvation windows.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.BW_STARVATION",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that when no operation was delivered to the back-end pipeline due =
to instruction fetch limitations when the back-end could have accepted more=
 operations. Common examples include instruction cache misses or x86 instru=
ction decode limitations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CORE",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that when no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations. Software can use this event as the numerator for=
 the Frontend Bound metric (or top-level category) of the Top-down Microarc=
hitecture Analysis method.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
+        "Invert": "1",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when no uops are delivered by the IDQ =
for 2 or more cycles when backend of the machine is not stalled - normally =
indicating a Fetch Latency issue",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.FETCH_LATENCY",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls for 2 or more cycles - normally in=
dicating a Fetch Latency issue.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "8",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.STARVATION_CYCLES",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/memory.json b/too=
ls/perf/pmu-events/arch/x86/diamondrapids/memory.json
new file mode 100644
index 000000000000..d3c37d1cdd2b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/memory.json
@@ -0,0 +1,295 @@
+[
+    {
+        "BriefDescription": "Number of machine clears due to memory orderi=
ng conflicts.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 due to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Execution stalls while L3 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x48"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than any number of cycles."=
,
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT",
+        "MSRIndex": "0x3F6",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than any number of cycles.=
  Reported latency may be longer than just the memory latency. Available PD=
IST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency. Available PDIST count=
ers: 0,1",
+        "SampleAfterValue": "53",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x80",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0,1",
+        "SampleAfterValue": "1009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 16 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x10",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0,1",
+        "SampleAfterValue": "20011",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2048 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency. Available PDIST count=
ers: 0,1",
+        "SampleAfterValue": "23",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x100",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0,1",
+        "SampleAfterValue": "503",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 32 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x20",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 4 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x4",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 512 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x200",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0,1",
+        "SampleAfterValue": "101",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 64 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x40",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0,1",
+        "SampleAfterValue": "2003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 8 cycles.",
+        "Counter": "2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x8",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0,1",
+        "SampleAfterValue": "50021",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired memory store access operations. A PDi=
st event for PEBS Store Latency Facility.",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
+        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8 Availab=
le PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_MISS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFFFFF000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_MISS Available PDIST c=
ounters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_RFO.L3_MISS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFFFFF000000002",
+        "PublicDescription": "OMR.DEMAND_RFO.L3_MISS Available PDIST count=
ers: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L3_MISS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L3_MISS",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFFFFF000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L3_MISS Available PDIST co=
unters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED",
+        "PublicDescription": "Counts the number of times RTM abort was tri=
ggered. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to none of the previous 3 categories (e.g. interrupt)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_EVENTS",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to none of the previous 3 categories (e.g. interrupt).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g. read/write capacity and conflicts)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_MEM",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to various memory events (e.g. read/write capacity and conflict=
s).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to incompatible memory type",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to incompatible memory type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to HLE-unfriendly instructions",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to HLE-unfriendly instructions.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution successfully=
 committed",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.COMMIT",
+        "PublicDescription": "Counts the number of times RTM commit succee=
ded.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution started.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.START",
+        "PublicDescription": "Counts the number of times we entered an RTM=
 region. Does not count nested transactions.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional reads",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CAPACITY_READ",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional writes.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data conflict on a transactionally accessed address",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CONFLICT",
+        "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/other.json b/tool=
s/perf/pmu-events/arch/x86/diamondrapids/other.json
new file mode 100644
index 000000000000..1f7d63b3167a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/other.json
@@ -0,0 +1,777 @@
+[
+    {
+        "BriefDescription": "Count all other hardware assists or traps tha=
t are not necessarily architecturally exposed (through a software handler) =
beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-eve=
nts.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.HARDWARE",
+        "PublicDescription": "Count all other hardware assists or traps th=
at are not necessarily architecturally exposed (through a software handler)=
 beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-ev=
ents.  This includes, but not limited to, assists at EXE or MEM uop writeba=
ck like AVX* load/store/gather/scatter (non-FP GSSE-assist ) , assists gene=
rated by ROB like PEBS and RTIT, Uncore trap, RAR (Remote Action Request) a=
nd CET (Control flow Enforcement Technology) assists.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "ASSISTS.PAGE_FAULT",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.PAGE_FAULT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of bubble cycles due to any Branch Pre=
dictor Clear (BpClear)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x82",
+        "EventName": "BPU.BPCLEAR_CYCLES",
+        "PublicDescription": "Number of bubble cycles due to any BpClear. =
Account for all BPClear/BTClear cases regardless of duration (1- or 2-cycle=
s).",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Core cycles during which interrupts are maske=
d.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcb",
+        "EventName": "HW_INTERRUPTS.MASKED",
+        "PublicDescription": "Core cycles during which interrupts are mask=
ed (disabled, when RFLAGS.IF is clear) while thread is Unhalted.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Core cycles during which there are pending in=
terrupts but interrupts are masked.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcb",
+        "EventName": "HW_INTERRUPTS.PENDING_AND_MASKED",
+        "PublicDescription": "Core cycles during which there are pending i=
nterrupts but interrupts are masked (disabled, when RFLAGS.IF is clear and =
there is pending interrupt from PIC) while thread is Unhalted.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of hardware interrupts received by the=
 processor.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcb",
+        "EventName": "HW_INTERRUPTS.RECEIVED",
+        "PublicDescription": "Counts the number of hardware interruptions =
received by the processor.",
+        "SampleAfterValue": "203",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "L0 d-cache writeback",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x52",
+        "EventName": "L1_RQSTS.L0_WB",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "LBR record is inserted [This event is alias t=
o MISC_RETIRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe4",
+        "EventName": "LBR_INSERTS.ANY",
+        "PublicDescription": "LBR record is inserted [This event is alias =
to MISC_RETIRED.LBR_INSERTS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Any memory transaction that reached the SQ.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x21",
+        "EventName": "OFFMODULE_REQUESTS.ALL_REQUESTS",
+        "PublicDescription": "Counts memory transactions reached the super=
 queue including requests initiated by the core, all L3 prefetches, page wa=
lks, etc..",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Demand and prefetch data reads",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x21",
+        "EventName": "OFFMODULE_REQUESTS.DATA_RD",
+        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cacheable and Non-Cacheable code read request=
s",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x21",
+        "EventName": "OFFMODULE_REQUESTS.DEMAND_CODE_RD",
+        "PublicDescription": "Counts both cacheable and Non-Cacheable code=
 read requests.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests sent to uncore",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x21",
+        "EventName": "OFFMODULE_REQUESTS.DEMAND_DATA_RD",
+        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFMODULE_REQUESTS_OUTSTANDING to deter=
mine average latency in the uncore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Demand RFO requests including regular RFOs, l=
ocks, ItoM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x21",
+        "EventName": "OFFMODULE_REQUESTS.DEMAND_RFO",
+        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles when offmodule outstanding cacheable C=
ore Data Read transactions are present in SuperQueue (SQ), queue to uncore.=
",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFMODULE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "PublicDescription": "Counts cycles when offmodule outstanding cac=
heable Core Data Read transactions are present in the super queue. A transa=
ction is considered to be in the Offmodule outstanding state between L2 mis=
s and transaction completion sent to requestor (SQ de-allocation). See corr=
esponding Umask under OFFMODULE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles with offmodule outstanding Code Reads =
transactions in the SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFMODULE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CO=
DE_RD",
+        "PublicDescription": "Counts the number of offmodule outstanding C=
ode Reads transactions in the super queue every cycle. The 'Offmodule outst=
anding' state of the transaction lasts from the L2 miss until the sending t=
ransaction completion to requestor (SQ deallocation). See the corresponding=
 Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles with offmodule outstanding demand rfo =
reads transactions in SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFMODULE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RF=
O",
+        "PublicDescription": "Counts the number of offmodule outstanding d=
emand rfo Reads transactions in the super queue every cycle. The 'Offmodule=
 outstanding' state of the transaction lasts from the L2 miss until the sen=
ding transaction completion to requestor (SQ deallocation). See the corresp=
onding Umask under OFFMODULE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Offmodule outstanding cacheable Core Data Rea=
d transactions in SuperQueue (SQ), queue to uncore",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFMODULE_REQUESTS_OUTSTANDING.DATA_RD",
+        "PublicDescription": "Counts the number of offmodule outstanding c=
acheable Core Data Read transactions in the super queue every cycle. A tran=
saction is considered to be in the Offmodule outstanding state between L2 m=
iss and transaction completion sent to requestor (SQ de-allocation). See co=
rresponding Umask under OFFMODULE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
outstanding demand data read requests pending.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFMODULE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
+        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.ANY_MEMORY",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.ANY_MEMORY",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5FF0000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.ANY_MEMORY Available PDIS=
T counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4000000000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.ANY_RESPONSE Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_ANY_CBB.HITM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_ANY_CBB.HITM",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFB002400000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_ANY_CBB.HITM Available=
 PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HIT.ANY_SOCKE=
T",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HIT.ANY_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFF002000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HIT.ANY_SOCK=
ET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HIT.LOCAL_SOC=
KET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HIT.LOCAL_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFD002000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HIT.LOCAL_SO=
CKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HIT.REMOTE_SO=
CKET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HIT.REMOTE_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFE002000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HIT.REMOTE_S=
OCKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITESF.ANY_SO=
CKET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITESF.ANY_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF7002000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITESF.ANY_S=
OCKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITESF.LOCAL_=
SOCKET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITESF.LOCAL_SOCKET"=
,
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5002000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITESF.LOCAL=
_SOCKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITESF.REMOTE=
_SOCKET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITESF.REMOTE_SOCKET=
",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF6002000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITESF.REMOT=
E_SOCKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITM.ANY_SOCK=
ET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITM.ANY_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFB002000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITM.ANY_SOC=
KET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITM.LOCAL_SO=
CKET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITM.LOCAL_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF9002000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITM.LOCAL_S=
OCKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITM.REMOTE_S=
OCKET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITM.REMOTE_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFA002000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_OTHER_CBB.HITM.REMOTE_=
SOCKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xED000400000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT Available=
 PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT.SNP_HIT_NO=
_FWD",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT.SNP_HIT_NO_FWD",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4D000400000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HIT.SNP_HIT_N=
O_FWD Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITESF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITESF",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE5000400000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITESF Availa=
ble PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITM",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE9000400000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.L3_SAME_CBB.HITM Availabl=
e PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_0",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.MEM_REGION_0",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5010000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_0 Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.MEM_REGION_1",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5020000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_1 Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.MEM_REGION_2",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5040000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_2 Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.MEM_REGION_3",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5080000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_3 Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_DATA_RD.MEM_REGION_4",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5100000000001",
+        "PublicDescription": "OMR.DEMAND_DATA_RD.MEM_REGION_4 Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_RFO.L3_ANY_CBB.HITM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_RFO.L3_ANY_CBB.HITM",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFB002400000002",
+        "PublicDescription": "OMR.DEMAND_RFO.L3_ANY_CBB.HITM Available PDI=
ST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_RFO.L3_OTHER_CBB.HITM.ANY_SOCKET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_RFO.L3_OTHER_CBB.HITM.ANY_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFB002000000002",
+        "PublicDescription": "OMR.DEMAND_RFO.L3_OTHER_CBB.HITM.ANY_SOCKET =
Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_RFO.L3_OTHER_CBB.HITM.LOCAL_SOCKET=
",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_RFO.L3_OTHER_CBB.HITM.LOCAL_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF9002000000002",
+        "PublicDescription": "OMR.DEMAND_RFO.L3_OTHER_CBB.HITM.LOCAL_SOCKE=
T Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_RFO.L3_OTHER_CBB.HITM.REMOTE_SOCKE=
T",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_RFO.L3_OTHER_CBB.HITM.REMOTE_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xFA002000000002",
+        "PublicDescription": "OMR.DEMAND_RFO.L3_OTHER_CBB.HITM.REMOTE_SOCK=
ET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.DEMAND_RFO.L3_SAME_CBB.HITM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.DEMAND_RFO.L3_SAME_CBB.HITM",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE9000400000002",
+        "PublicDescription": "OMR.DEMAND_RFO.L3_SAME_CBB.HITM Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.MODIFIED_WRITE.ANY_RESPONSE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.MODIFIED_WRITE.ANY_RESPONSE",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4000000000000808",
+        "PublicDescription": "OMR.MODIFIED_WRITE.ANY_RESPONSE Available PD=
IST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.ANY_MEMORY",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.ANY_MEMORY",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5FF0000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.ANY_MEMORY Available PDIST=
 counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.ANY_RESPONSE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.ANY_RESPONSE",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4000000000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.ANY_RESPONSE Available PDI=
ST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L2_HITESF_OTHER_CBB_LOCAL_S=
OCKET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L2_HITESF_OTHER_CBB_LOCAL_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE5004000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L2_HITESF_OTHER_CBB_LOCAL_=
SOCKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L2_HITM_OTHER_CBB_LOCAL_SOC=
KET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L2_HITM_OTHER_CBB_LOCAL_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE9004000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L2_HITM_OTHER_CBB_LOCAL_SO=
CKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L2_OTHER_CBB.HITESF.LOCAL_S=
OCKET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L2_OTHER_CBB.HITESF.LOCAL_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE5004000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L2_OTHER_CBB.HITESF.LOCAL_=
SOCKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L2_OTHER_CBB.HITM.LOCAL_SOC=
KET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L2_OTHER_CBB.HITM.LOCAL_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE9004000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L2_OTHER_CBB.HITM.LOCAL_SO=
CKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L2_OTHER_MODULE.SAME_CBB.HI=
TESF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L2_OTHER_MODULE.SAME_CBB.HITESF",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xC5000800004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L2_OTHER_MODULE.SAME_CBB.H=
ITESF Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L2_OTHER_MODULE.SAME_CBB.HI=
TM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L2_OTHER_MODULE.SAME_CBB.HITM",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xC9000800004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L2_OTHER_MODULE.SAME_CBB.H=
ITM Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L3_HITESF_OTHER_CBB_LOCAL_S=
OCKET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L3_HITESF_OTHER_CBB_LOCAL_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5002000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L3_HITESF_OTHER_CBB_LOCAL_=
SOCKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L3_HITESF_SAME_CBB",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L3_HITESF_SAME_CBB",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE5000400004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L3_HITESF_SAME_CBB Availab=
le PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L3_HITM_OTHER_CBB_LOCAL_SOC=
KET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L3_HITM_OTHER_CBB_LOCAL_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF9002000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L3_HITM_OTHER_CBB_LOCAL_SO=
CKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L3_HITM_SAME_CBB",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L3_HITM_SAME_CBB",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE9000400004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L3_HITM_SAME_CBB Available=
 PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L3_OTHER_CBB.HITESF.LOCAL_S=
OCKET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L3_OTHER_CBB.HITESF.LOCAL_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF5002000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L3_OTHER_CBB.HITESF.LOCAL_=
SOCKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L3_OTHER_CBB.HITM.LOCAL_SOC=
KET",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L3_OTHER_CBB.HITM.LOCAL_SOCKET",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xF9002000004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L3_OTHER_CBB.HITM.LOCAL_SO=
CKET Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L3_SAME_CBB.HITESF",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L3_SAME_CBB.HITESF",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE5000400004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L3_SAME_CBB.HITESF Availab=
le PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.L3_SAME_CBB.HITM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.L3_SAME_CBB.HITM",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xE9000400004477",
+        "PublicDescription": "OMR.READS_TO_CORE.L3_SAME_CBB.HITM Available=
 PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.OTHER_MODULE_L2_HITESF_SAME=
_CBB",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.OTHER_MODULE_L2_HITESF_SAME_CBB",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xC5000800004477",
+        "PublicDescription": "OMR.READS_TO_CORE.OTHER_MODULE_L2_HITESF_SAM=
E_CBB Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.READS_TO_CORE.OTHER_MODULE_L2_HITM_SAME_C=
BB",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.READS_TO_CORE.OTHER_MODULE_L2_HITM_SAME_CBB",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0xC9000800004477",
+        "PublicDescription": "OMR.READS_TO_CORE.OTHER_MODULE_L2_HITM_SAME_=
CBB Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OMR.STREAMING_WR.ANY_RESPONSE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A",
+        "EventName": "OMR.STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x3E0,0x3E1,0x3E2,0x3E3",
+        "MSRValue": "0x4000000000000800",
+        "PublicDescription": "OMR.STREAMING_WR.ANY_RESPONSE Available PDIS=
T counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "number of port pushouts of integer ports (rea=
dy uop was delayed due to port being used by another uop) including integer=
 STD.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xab",
+        "EventName": "PORT_PUSHOUT.INTEGER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "number of port pushouts of memory exec ports =
(ready uop was delayed due to port being used by another uop)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xab",
+        "EventName": "PORT_PUSHOUT.MEM_ADDRESS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "number of port pushouts of vector ports (read=
y uop was delayed due to port being used by another uop)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xab",
+        "EventName": "PORT_PUSHOUT.VECTOR",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of integer uops scheduled for executio=
n (no cancel) including integer STD uops - ports with ready uops",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xaa",
+        "EventName": "PORT_READY.INTEGER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of memory AGU uops scheduled for execu=
tion (no cancel) - ports with ready uops",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xaa",
+        "EventName": "PORT_READY.MEM_ADDRESS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of vector uops scheduled for execution=
 (no cancel) including vec/fp STD uops- ports with ready uops",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xaa",
+        "EventName": "PORT_READY.VECTOR",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Alloc Stall cycles when stall is due to gener=
al shared resource (e.g. ROB) and is not MEMORY_BOUND stall",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa9",
+        "EventName": "STALL_CORE_BOUND.GENERAL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Alloc Stall cycles when stall is due to integ=
er stack resource and is not MEMORY_BOUND stall",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa9",
+        "EventName": "STALL_CORE_BOUND.INTEGER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Alloc Stall cycles when stall is due to MEM R=
S resource and is not MEMORY_BOUND stall",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa9",
+        "EventName": "STALL_CORE_BOUND.MEM_ADDRESS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Alloc Stall cycles when the stall is due to M=
EM RS resource or other memory resource and is not MEMORY_BOUND",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa9",
+        "EventName": "STALL_CORE_BOUND.MEM_RESOURCE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x14"
+    },
+    {
+        "BriefDescription": "Alloc Stall cycles when stall is due to seria=
lization and is not MEMORY_BOUND stall",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa9",
+        "EventName": "STALL_CORE_BOUND.SERIALIZATION",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Alloc Stall cycles when stall is due to vecto=
r stack resource and is not MEMORY_BOUND stall",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa9",
+        "EventName": "STALL_CORE_BOUND.VECTOR",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles the uncore cannot take further request=
s",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0x2d",
+        "EventName": "XQ.FULL",
+        "PublicDescription": "number of cycles when the thread is active a=
nd the uncore cannot take any further requests (for example prefetches, loa=
ds or stores initiated by the Core that miss the L2 cache).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/diamondrapids/pipeline.json
new file mode 100644
index 000000000000..cde1e1047612
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/pipeline.json
@@ -0,0 +1,1423 @@
+[
+    {
+        "BriefDescription": "AMX retired arithmetic BF16 operations.",
+        "Counter": "0",
+        "EventCode": "0xce",
+        "EventName": "AMX_OPS_RETIRED.BF16",
+        "PublicDescription": "Number of AMX-based retired arithmetic bfloa=
t16 (BF16) floating-point operations. Counts TDPBF16PS FP instructions. SW =
to use operation multiplier of 4",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "AMX retired arithmetic half-precision FP oper=
ations.",
+        "Counter": "0",
+        "EventCode": "0xce",
+        "EventName": "AMX_OPS_RETIRED.FP16",
+        "PublicDescription": "Number of AMX-based retired arithmetic half-=
precision floating-point operations. Counts TDPFP16PS FP instructions. SW t=
o use operation multiplier of 4.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of AMX-based retired arithmetic operat=
ions of FP8 datatype. SW should use operation multiplier of 8.",
+        "Counter": "0",
+        "EventCode": "0xce",
+        "EventName": "AMX_OPS_RETIRED.FP8",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "AMX retired arithmetic integer 8-bit operatio=
ns.",
+        "Counter": "0",
+        "EventCode": "0xce",
+        "EventName": "AMX_OPS_RETIRED.INT8",
+        "PublicDescription": "Number of AMX-based retired arithmetic integ=
er operations of 8-bit width source operands. Counts TDPB[SS,UU,US,SU]D ins=
tructions. SW should use operation multiplier of 8.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "Cycles when integer divide unit is busy execu=
ting divide or square root operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer operations only=
.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "This event counts the number of integer divid=
e instructions executed this cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.IDIV_INST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.ANY",
+        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1f"
+    },
+    {
+        "BriefDescription": "Cycles there was microcode scoreboard stall",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa2",
+        "EventName": "BE_STALLS.SCOREBOARD",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "All branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "PublicDescription": "Counts all branch instructions retired. Avai=
lable PDIST counters: 0,1",
+        "SampleAfterValue": "400009"
+    },
+    {
+        "BriefDescription": "Conditional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PublicDescription": "Counts conditional branch instructions retir=
ed. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Not taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_NTAKEN",
+        "PublicDescription": "Counts not taken branch instructions retired=
. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Taken conditional branch instructions retired=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PublicDescription": "Counts taken conditional branch instructions=
 retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Taken backward conditional branch instruction=
s retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN_BWD",
+        "PublicDescription": "Counts taken backward conditional branch ins=
tructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Taken forward conditional branch instructions=
 retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
+        "PublicDescription": "Counts taken forward conditional branch inst=
ructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Far branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
+        "PublicDescription": "Counts far branch instructions retired. Avai=
lable PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x100"
+    },
+    {
+        "BriefDescription": "Direct and indirect near call instructions re=
tired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PublicDescription": "Counts both direct and indirect near call in=
structions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x30"
+    },
+    {
+        "BriefDescription": "near direct call instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_DIRECT_CALL",
+        "PublicDescription": "Counts near direct call instructions retired=
. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "near direct jump instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_DIRECT_JMP",
+        "PublicDescription": "Counts near direct jump instructions retired=
. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Indirect near branch instructions retired (ex=
cluding returns)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT",
+        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch. Available PDIST co=
unters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x50"
+    },
+    {
+        "BriefDescription": "Indirect near call instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT_CALL",
+        "PublicDescription": "Counts indirect near call instructions retir=
ed. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Indirect near jump instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT_JMP",
+        "PublicDescription": "Counts indirect near jump instructions retir=
ed. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Indirect and Direct Relative near jump instru=
ctions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_JMP",
+        "PublicDescription": "Counts near jump instructions retired. Avail=
able PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0xc0"
+    },
+    {
+        "BriefDescription": "Return instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PublicDescription": "Counts return instructions retired. Availabl=
e PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "PublicDescription": "Counts taken branch instructions retired. Av=
ailable PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0xfb"
+    },
+    {
+        "BriefDescription": "All mispredicted branch instructions retired.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009"
+    },
+    {
+        "BriefDescription": "All mispredicted branch instructions retired.=
 This precise event may be used to get the misprediction cost via the Retir=
e_Latency field of PEBS. It fires on the instruction that immediately follo=
ws the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_TPEBS",
+        "PublicDescription": "All mispredicted branch instructions retired=
. This precise event may be used to get the misprediction cost via the Reti=
re_Latency field of PEBS. It fires on the instruction that immediately foll=
ows the mispredicted branch. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8000"
+    },
+    {
+        "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND",
+        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
+        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired. This precise event may be used to get the misprediction =
cost via the Retire_Latency field of PEBS. It fires on the instruction that=
 immediately follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN_TPEBS",
+        "PublicDescription": "Mispredicted non-taken conditional branch in=
structions retired. This precise event may be used to get the misprediction=
 cost via the Retire_Latency field of PEBS. It fires on the instruction tha=
t immediately follows the mispredicted branch. Available PDIST counters: 0,=
1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8004"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken backward.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_BWD",
+        "PublicDescription": "Counts taken backward conditional mispredict=
ed branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken backward. This precise event may be used to get t=
he misprediction cost via the Retire_Latency field of PEBS. It fires on the=
 instruction that immediately follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_BWD_TPEBS",
+        "PublicDescription": "number of branch instructions retired that w=
ere mispredicted and taken backward. This precise event may be used to get =
the misprediction cost via the Retire_Latency field of PEBS. It fires on th=
e instruction that immediately follows the mispredicted branch. Available P=
DIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8001"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken forward.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_FWD",
+        "PublicDescription": "Counts taken forward conditional mispredicte=
d branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken forward. This precise event may be used to get th=
e misprediction cost via the Retire_Latency field of PEBS. It fires on the =
instruction that immediately follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_FWD_TPEBS",
+        "PublicDescription": "number of branch instructions retired that w=
ere mispredicted and taken forward. This precise event may be used to get t=
he misprediction cost via the Retire_Latency field of PEBS. It fires on the=
 instruction that immediately follows the mispredicted branch. Available PD=
IST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8002"
+    },
+    {
+        "BriefDescription": "Mispredicted taken conditional branch instruc=
tions retired. This precise event may be used to get the misprediction cost=
 via the Retire_Latency field of PEBS. It fires on the instruction that imm=
ediately follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_TPEBS",
+        "PublicDescription": "Mispredicted taken conditional branch instru=
ctions retired. This precise event may be used to get the misprediction cos=
t via the Retire_Latency field of PEBS. It fires on the instruction that im=
mediately follows the mispredicted branch. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8003"
+    },
+    {
+        "BriefDescription": "Mispredicted conditional branch instructions =
retired. This precise event may be used to get the misprediction cost via t=
he Retire_Latency field of PEBS. It fires on the instruction that immediate=
ly follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TPEBS",
+        "PublicDescription": "Mispredicted conditional branch instructions=
 retired. This precise event may be used to get the misprediction cost via =
the Retire_Latency field of PEBS. It fires on the instruction that immediat=
ely follows the mispredicted branch. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8007"
+    },
+    {
+        "BriefDescription": "Miss-predicted near indirect branch instructi=
ons retired (excluding returns)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT",
+        "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch. Ava=
ilable PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x50"
+    },
+    {
+        "BriefDescription": "Mispredicted indirect CALL retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_CALL",
+        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect. Avail=
able PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Mispredicted indirect CALL retired. This prec=
ise event may be used to get the misprediction cost via the Retire_Latency =
field of PEBS. It fires on the instruction that immediately follows the mis=
predicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_CALL_TPEBS",
+        "PublicDescription": "Mispredicted indirect CALL retired. This pre=
cise event may be used to get the misprediction cost via the Retire_Latency=
 field of PEBS. It fires on the instruction that immediately follows the mi=
spredicted branch. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8010"
+    },
+    {
+        "BriefDescription": "Miss-predicted near indirect jump instruction=
s retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_JMP",
+        "PublicDescription": "Miss-predicted near indirect jump instructio=
ns retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Miss-predicted near indirect jump instruction=
s retired. Precise cost.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_JMP_TPEBS",
+        "PublicDescription": "Miss-predicted near indirect jump instructio=
ns retired. Precise cost. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8040"
+    },
+    {
+        "BriefDescription": "Miss-predicted near indirect branch instructi=
ons retired (excluding returns)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_TPEBS",
+        "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch. Ava=
ilable PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8050"
+    },
+    {
+        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_RETURN",
+        "PublicDescription": "This event counts the number of mispredicted=
 ret instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Mispredicted ret instructions retired. This p=
recise event may be used to get the misprediction cost via the Retire_Laten=
cy field of PEBS. It fires on the instruction that immediately follows the =
mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_RETURN_TPEBS",
+        "PublicDescription": "Mispredicted ret instructions retired. This =
precise event may be used to get the misprediction cost via the Retire_Late=
ncy field of PEBS. It fires on the instruction that immediately follows the=
 mispredicted branch. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8008"
+    },
+    {
+        "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0xfb"
+    },
+    {
+        "BriefDescription": "Mispredicted taken near branch instructions r=
etired. This precise event may be used to get the misprediction cost via th=
e Retire_Latency field of PEBS. It fires on the instruction that immediatel=
y follows the mispredicted branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN_TPEBS",
+        "PublicDescription": "Mispredicted taken near branch instructions =
retired. This precise event may be used to get the misprediction cost via t=
he Retire_Latency field of PEBS. It fires on the instruction that immediate=
ly follows the mispredicted branch. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x80fb"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 li=
ght-weight slower wakeup time but more power saving optimized state.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C01",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.2 li=
ght-weight faster wakeup time but less power saving optimized state.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C02",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 or=
 C0.2 or running a PAUSE in C0 ACPI state.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x70"
+    },
+    {
+        "BriefDescription": "Core cycles when the core is not in a halt st=
ate.",
+        "Counter": "Fixed counter 1",
+        "EventName": "CPU_CLK_UNHALTED.CORE",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. This event is a component in many key event ratios.=
 The core frequency may change from time to time due to transitions associa=
ted with Enhanced Intel SpeedStep Technology or TM2. For this reason this e=
vent may have a changing ratio with regards to time. When the core frequenc=
y is constant, this event can approximate elapsed time while the core was n=
ot in the halt state. It is counted on a dedicated fixed counter, leaving t=
he programmable counters available for other events.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Thread cycles when thread is not in halt stat=
e [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.CORE_P",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Core clocks when a PAUSE is pending.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Number of Pause instructions",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "Fixed counter 2",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. Note: =
On all current platforms this event stops counting during 'throttling (TM)'=
 states duty off periods the processor is 'halted'.  The counter update is =
done at a lower clock rate then the core clock the overflow status bit for =
this counter may appear 'sticky'.  After the counter has overflowed and sof=
tware clears the overflow status bit and resets the counter to less than MA=
X. The reset value to the counter is not clocked immediately so the overflo=
w status bit will flip 'high (1)' and generate another PMI (if enabled) aft=
er which the reset value gets clocked into the counter. Therefore, software=
 will get the interrupt, read the overflow status bit '1 for bit 34 while t=
he counter value is less than MAX. Software should ignore this case.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. Note: =
On all current platforms this event stops counting during 'throttling (TM)'=
 states duty off periods the processor is 'halted'.  The counter update is =
done at a lower clock rate then the core clock the overflow status bit for =
this counter may appear 'sticky'.  After the counter has overflowed and sof=
tware clears the overflow status bit and resets the counter to less than MA=
X. The reset value to the counter is not clocked immediately so the overflo=
w status bit will flip 'high (1)' and generate another PMI (if enabled) aft=
er which the reset value gets clocked into the counter. Therefore, software=
 will get the interrupt, read the overflow status bit '1 for bit 34 while t=
he counter value is less than MAX. Software should ignore this case.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Core cycles when the thread is not in a halt =
state.",
+        "Counter": "Fixed counter 1",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the programmable counters available for other events.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Thread cycles when thread is not in halt stat=
e [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
+        "Counter": "2",
+        "CounterMask": "8",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
+        "Counter": "3",
+        "CounterMask": "16",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Total execution stalls.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "4",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Count number of times a load is depending on =
another load that had just write back its data or in previous or 2 cycles b=
ack. This event supports in-direct dependency through a single uop.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x02",
+        "EventName": "DEPENDENT_LOADS.ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Counts the cycles where the AMX (Advance Matr=
ix Extension) unit is busy performing an arithmetic operation.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb7",
+        "EventName": "EXE.AMX_BUSY_ARITH",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles total of 1 uop is executed on all port=
s and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
+        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles total of 2 or 3 uops are executed on a=
ll ports and Reservation Station (RS) was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.2_3_PORTS_UTIL",
+        "SampleAfterValue": "2000003",
+        "UMask": "0xc"
+    },
+    {
+        "BriefDescription": "Cycles total of 2 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
+        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles total of 3 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
+        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles total of 4 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
+        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "5",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Cycles where the Store Buffer was full and no=
 loads caused an execution stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "2",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
+        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Cycles no uop executed while RS was not empty=
, the SB was not full and there was no outstanding load.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
+        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "EXE_RETIRED.ANY",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xdf",
+        "EventName": "EXE_RETIRED.ANY",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Retired conditional instructions (e.g. CMOV) =
where condition was false",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xdf",
+        "EventName": "EXE_RETIRED.CMOV_NTAKEN",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired conditional instructions (e.g. CMOV) =
where condition was true",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xdf",
+        "EventName": "EXE_RETIRED.CMOV_TAKEN",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "INST_DECODED.DEC_BW_3MU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x75",
+        "EventName": "INST_DECODED.DEC_BW_3MU",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
+        "Counter": "Fixed counter 0",
+        "EventName": "INST_RETIRED.ANY",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter. A=
vailable PDIST counters: 32",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter. A=
vailable PDIST counters: 0,1",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "retired macro-fused uops when there is a bran=
ch in the macro-fused pair (the two instructions that got macro-fused count=
 once in this pmon)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.BR_FUSED",
+        "PublicDescription": "retired macro-fused uops when there is a bra=
nch in the macro-fused pair (the two instructions that got macro-fused coun=
t once in this pmon) Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "INST_RETIRED.MACRO_FUSED",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.MACRO_FUSED",
+        "PublicDescription": "INST_RETIRED.MACRO_FUSED Available PDIST cou=
nters: 0,1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x30"
+    },
+    {
+        "BriefDescription": "Retired NOP instructions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.NOP",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREF=
ETCHIT0/1 instructions Available PDIST counters: 0,1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
+        "Counter": "Fixed counter 0",
+        "EventName": "INST_RETIRED.PREC_DIST",
+        "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0. Available=
 PDIST counters: 32",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Iterations of Repeat string retired instructi=
ons.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.REP_ITERATION",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary run to run and not match the architectural =
number of iterations (specified by RCX) Available PDIST counters: 0,1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Bubble cycles of BPClear. [This event is alia=
s to INT_MISC.BPCLEAR_CYCLES]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.BPCLEAR_BUBBLES",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0xB",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Bubble cycles of BPClear. [This event is alia=
s to INT_MISC.BPCLEAR_BUBBLES]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.BPCLEAR_CYCLES",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0xB",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Clears speculative count",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.CLEARS_COUNT",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cycles after recovery from a branch mi=
sprediction or machine clear till the first uop is issued from the resteere=
d path.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
+        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "INT_MISC.MBA_STALLS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.MBA_STALLS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.RECOVERY_CYCLES",
+        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "INT_MISC.UNKNOWN_BRANCH",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UNKNOWN_BRANCH",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Bubble cycles of BAClear (Unknown Branch). [T=
his event is alias to INT_MISC.UNKNOWN_BRANCH_CYCLES]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UNKNOWN_BRANCH_BUBBLES",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Bubble cycles of BAClear (Unknown Branch). [T=
his event is alias to INT_MISC.UNKNOWN_BRANCH_BUBBLES]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "TMA slots where uops got dropped",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UOP_DROPPING",
+        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Number of vector integer instructions retired=
 of 128-bit vector-width.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.128BIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x13"
+    },
+    {
+        "BriefDescription": "Number of vector integer instructions retired=
 of 256-bit vector-width.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.256BIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xac"
+    },
+    {
+        "BriefDescription": "integer ADD, SUB, SAD 128-bit vector instruct=
ions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.ADD_128",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "integer ADD, SUB, SAD 256-bit vector instruct=
ions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.ADD_256",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.MUL_256",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.MUL_256",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.SHUFFLES",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.SHUFFLES",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_128",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.VNNI_128",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_256",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.VNNI_256",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Bank conflicts in DCU due to limited lookup p=
orts.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.BANK_CONFLICT",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to bank conflicts in DCU",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.NO_SR",
+        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x88"
+    },
+    {
+        "BriefDescription": "Counts the number of times a load got early b=
locked due to preceding store operation with unknown address or unknown dat=
a. Excluding in-line (immediate) wakeups",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_EARLY",
+        "SampleAfterValue": "100003",
+        "UMask": "0xa1"
+    },
+    {
+        "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x82"
+    },
+    {
+        "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xa8",
+        "EventName": "LSD.CYCLES_ACTIVE",
+        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles optimal number of Uops delivered by th=
e LSD, but did not come from the decoder.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "8",
+        "EventCode": "0xa8",
+        "EventName": "LSD.CYCLES_OK",
+        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of Uops delivered by the LSD.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa8",
+        "EventName": "LSD.UOPS",
+        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of machine clears (nukes) of any type.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.COUNT",
+        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Self-modifying code (SMC) detected.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts cycles where no execution is happening=
 due to loads waiting for L1 cache (that is: no execution & load in flight =
& no load missed L1 cache)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x46",
+        "EventName": "MEMORY_STALLS.L1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cycles where no execution is happening=
 due to loads waiting for L2 cache (that is: no execution & load in flight =
& load missed L1 & no load missed L2 cache)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x46",
+        "EventName": "MEMORY_STALLS.L2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts cycles where no execution is happening=
 due to loads waiting for L3 cache (that is: no execution & load in flight =
& load missed L1 & load missed L2 cache & no load missed L3 Cache)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "MEMORY_STALLS.L3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts cycles where no execution is happening=
 due to loads waiting for Memory (that is: no execution & load in flight & =
a load missed L3 cache)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "MEMORY_STALLS.MEM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "LFENCE instructions retired",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC2_RETIRED.LFENCE",
+        "PublicDescription": "number of LFENCE retired instructions",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "LBR record is inserted [This event is alias t=
o LBR_INSERTS.ANY]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PublicDescription": "LBR record is inserted [This event is alias =
to LBR_INSERTS.ANY] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Count micro branches that gets mispredicted",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.UBR_MISP",
+        "PublicDescription": "Count micro branches that gets mispredicted =
Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_COUNT",
+        "Invert": "1",
+        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
+        "SampleAfterValue": "100003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Cycles when RS was empty and a resource alloc=
ation stall is asserted",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_RESOURCE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions. Software can use this event as the numerat=
or for the Backend Bound metric (or top-level category) of the Top-down Mic=
roarchitecture Analysis method.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "TMA slots wasted due to incorrect speculation=
s.",
+        "Counter": "0",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
+        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
+        "Counter": "0",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "Counter": "3",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
+        "Counter": "Fixed counter 3",
+        "EventName": "TOPDOWN.SLOTS",
+        "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
Software can use this event as the denominator for the top-level metrics of=
 the TMA method. This architectural event is counted on a designated fixed =
counter (Fixed Counter 3).",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. General counter - architectural event",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.SLOTS_P",
+        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event counts the number of not dec-by-al=
l uops decoded (any non dec-by-all uops) e.g. when a 2 uop instruction is d=
ecoded this events counts 2.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x76",
+        "EventName": "UOPS_DECODED.HEAVY_INST_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Uops executed on INT EU ALU ports.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.ALU",
+        "PublicDescription": "Number of ALU integer uops dispatch to execu=
tion.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Uops executed on any INT EU ports",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.INT_EU_ALL",
+        "PublicDescription": "Number of integer uops dispatched to executi=
on.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of Uops dispatched/executed by any of =
the 3 JEUs (all ups that hold the JEU including macro; micro jumps; fetch-f=
rom-eip)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.JMP",
+        "PublicDescription": "Number of jump uops dispatch to execution",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Uops executed on Load ports",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.LOAD",
+        "PublicDescription": "Number of Load uops dispatched to execution.=
",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of (shift) 1-cycle Uops dispatched/exe=
cuted by any of the Shift Eus",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.SHIFT",
+        "PublicDescription": "Number of SHIFT integer uops dispatch to exe=
cution",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Number of Uops dispatched/executed by Slow EU=
 (e.g. 3+ cycles LEA, >1 cycles shift, iDIVs, CR; *H operation)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.SLOW",
+        "PublicDescription": "Number of Slow integer uops dispatch to exec=
ution.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of Uops dispatched on STA ports",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.STA",
+        "PublicDescription": "Number of STA (Store Address) uops dispatch =
to execution",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Uops executed on STD ports",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.STD",
+        "PublicDescription": "Number of STD (Store Data) uops dispatch to =
execution",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
+        "Counter": "3",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
+        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 10 uops was executed pe=
r-thread",
+        "Counter": "3",
+        "CounterMask": "10",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_10",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
+        "Counter": "3",
+        "CounterMask": "2",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
+        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
+        "Counter": "3",
+        "CounterMask": "3",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
+        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread",
+        "Counter": "3",
+        "CounterMask": "4",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
+        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 6 uops was executed per=
-thread",
+        "Counter": "3",
+        "CounterMask": "6",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_6",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 8 uops was executed per=
-thread",
+        "Counter": "3",
+        "CounterMask": "8",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_8",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
+        "Counter": "3",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.STALLS",
+        "Invert": "1",
+        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of uops to be executed per-=
thread each cycle.",
+        "Counter": "3",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.THREAD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of x87 uops dispatched.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.X87",
+        "PublicDescription": "Counts the number of x87 uops executed.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Uops that RAT issues to RS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xae",
+        "EventName": "UOPS_ISSUED.ANY",
+        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "UOPS_ISSUED.CYCLES",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xae",
+        "EventName": "UOPS_ISSUED.CYCLES",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles with retired uop(s).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.CYCLES",
+        "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.HEAVY",
+        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "UOPS_RETIRED.MS",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of non-speculative switches to the Mic=
rocode Sequencer (MS)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS_SWITCHES",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "PublicDescription": "Switches to the Microcode Sequencer",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that are utilized by operations that eventually get retired (commi=
tted) by the processor pipeline. Usually, this event positively correlates =
with higher performance  for example, as measured by the instructions-per-c=
ycle metric.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.SLOTS",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that are utilized by operations that eventually get retired (comm=
itted) by the processor pipeline. Usually, this event positively correlates=
 with higher performance  for example, as measured by the instructions-per-=
cycle metric. Software can use this event as the numerator for the Retiring=
 metric (or top-level category) of the Top-down Microarchitecture Analysis =
method.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles without actually retired uops.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.STALLS",
+        "Invert": "1",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C0",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V4",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts number of vector uops dispatched on VE=
C5",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb4",
+        "EventName": "VEC_DISPATCHED.V5",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cache.json=
 b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cache.json
new file mode 100644
index 000000000000..c657163f21f7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cache.json
@@ -0,0 +1,292 @@
+[
+    {
+        "BriefDescription": "LLC Lookup request that access cache and hit =
the LLC with the CRD opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.HIT_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_CACHE_LOOKUP.HIT_CRD",
+        "UMask": "0xc0a00f7",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "LLC Lookup request that access cache and hit =
the LLC with the CRD_Pref opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.HIT_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_CACHE_LOOKUP.HIT_CRD_PREF",
+        "UMask": "0xc8a00f7",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "LLC Lookup request that access cache and hit =
the LLC with the DRd_Opt opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.HIT_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_CACHE_LOOKUP.HIT_DRD_OPT",
+        "UMask": "0xc2200f7",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "LLC Lookup request that access cache and hit =
the LLC with the DRd_Opt_Pref opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.HIT_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_CACHE_LOOKUP.HIT_DRD_OPT_PREF",
+        "UMask": "0xca200f7",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "LLC Lookup request that access cache and hit =
the LLC with the LlcPrefCode opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.HIT_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_CACHE_LOOKUP.HIT_LLCPREFCODE",
+        "UMask": "0xcea00f7",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "LLC Lookup request that access cache and hit =
the LLC with the LlcPrefData opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.HIT_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_CACHE_LOOKUP.HIT_LLCPREFDATA",
+        "UMask": "0xed200f7",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "LLC Lookup request that access cache and hit =
the LLC with the LlcPrefRFO opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.HIT_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_CACHE_LOOKUP.HIT_LLCPREFRFO",
+        "UMask": "0xec200f7",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "LLC Lookup request that access cache and hit =
the LLC with the ReadForOwnership opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.HIT_READFOROWNERSHIP",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_CACHE_LOOKUP.HIT_READFOROWNERSHIP",
+        "UMask": "0xc0200f7",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "LLC Lookup request that access cache and hit =
the LLC with the RFO_Pref opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.HIT_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_CACHE_LOOKUP.HIT_RFO_PREF",
+        "UMask": "0xc8200f7",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "Increments once per CBO clock, runs at UCLK (=
2700Mhz default)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_CBO_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_CLOCKTICKS",
+        "UMask": "0x1",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "Number of valid TOR entries in each cycle wit=
h the CLFlush opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.ALL_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.ALL_CLFLUSH",
+        "UMask": "0xcc20008",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "Number of valid TOR entries in each cycle wit=
h the CLFlushOpt opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.ALL_CLFLUSHOPT",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.ALL_CLFLUSHOPT",
+        "UMask": "0xcd20008",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "Number of valid TOR entries in each cycle wit=
h the SpecItoM opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.ALL_SPECITOM",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.ALL_SPECITOM",
+        "UMask": "0xe520008",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "All TOR Allocations which miss the cache and =
have the CRD opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.MISS_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.MISS_CRD",
+        "UMask": "0xc0a0002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "All TOR Allocations which miss the cache and =
have the CRd_Pref opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.MISS_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.MISS_CRD_PREF",
+        "UMask": "0xc8a0002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "All TOR Allocations which miss the cache and =
have the DrdPTE opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.MISS_DRDPTE",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.MISS_DRDPTE",
+        "UMask": "0xc320002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "All TOR Allocations which miss the cache and =
have the DRd_Opt opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.MISS_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.MISS_DRD_OPT",
+        "UMask": "0xc220002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "All TOR Allocations which miss the cache and =
have the DRd_Opt_Pref opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.MISS_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.MISS_DRD_OPT_PREF",
+        "UMask": "0xca20002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "All TOR Allocations which miss the cache and =
have the LlcPrefCode opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.MISS_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.MISS_LLCPREFCODE",
+        "UMask": "0xcea0002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "All TOR Allocations which miss the cache and =
have the LlcPrefData opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.MISS_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.MISS_LLCPREFDATA",
+        "UMask": "0xed20002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "All TOR Allocations which miss the cache and =
have the LlcPrefRFO opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.MISS_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.MISS_LLCPREFRFO",
+        "UMask": "0xec20002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "All TOR Allocations which miss the cache and =
have the ReadForOwnership opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.MISS_READFOROWNERSHIP",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.MISS_READFOROWNERSHIP=
",
+        "UMask": "0xc020002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "All TOR Allocations which miss the cache and =
have the RFO_Pref opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CBO_TOR_ALLOCATION.MISS_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_ALLOCATION.MISS_RFO_PREF",
+        "UMask": "0xc820002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "Number of valid TOR entries in each cycle whi=
ch miss the cache and have the DRd_Opt opcode",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CBO_TOR_OCCUPANCY.MISS_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_OCCUPANCY.MISS_DRD_OPT",
+        "UMask": "0xc220002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "Number of valid TOR entries in each cycle whi=
ch miss the cache and have the DRd_Opt_Pref opcode",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CBO_TOR_OCCUPANCY.MISS_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_OCCUPANCY.MISS_DRD_OPT_PREF",
+        "UMask": "0xca20002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "Number of valid TOR entries in each cycle whi=
ch miss the cache and have the LlcPrefData opcode",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CBO_TOR_OCCUPANCY.MISS_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_OCCUPANCY.MISS_LLCPREFDATA",
+        "UMask": "0xed20002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "Number of valid TOR entries in each cycle whi=
ch miss the cache and have the LlcPrefRFO opcode",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CBO_TOR_OCCUPANCY.MISS_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_OCCUPANCY.MISS_LLCPREFRFO",
+        "UMask": "0xec20002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "Number of valid TOR entries in each cycle whi=
ch miss the cache and have the ReadForOwnership opcode",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CBO_TOR_OCCUPANCY.MISS_READFOROWNERSHIP",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_OCCUPANCY.MISS_READFOROWNERSHIP"=
,
+        "UMask": "0xc020002",
+        "Unit": "CBOX"
+    },
+    {
+        "BriefDescription": "Number of valid TOR entries in each cycle whi=
ch miss the cache and have the RFO_Pref opcode",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CBO_TOR_OCCUPANCY.MISS_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CBO_TOR_OCCUPANCY.MISS_RFO_PREF",
+        "UMask": "0xc820002",
+        "Unit": "CBOX"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cxl.json b=
/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cxl.json
new file mode 100644
index 000000000000..b692606bcd63
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cxl.json
@@ -0,0 +1,22 @@
+[
+    {
+        "BriefDescription": "Number of Allocation to Mem Data Packing buff=
er",
+        "Counter": "4,5,6,7",
+        "EventCode": "0x41",
+        "EventName": "UNC_CXLCM_RX_PACK_BUF_INSERTS.MEM_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CXLCM_RX_PACK_BUF_INSERTS.MEM_DATA",
+        "UMask": "0xf10",
+        "Unit": "CXLCM"
+    },
+    {
+        "BriefDescription": "Number of Allocation to Mem Data Packing buff=
er",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_CXLCM_TX_PACK_BUF_INSERTS.MEM_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CXLCM_TX_PACK_BUF_INSERTS.MEM_DATA",
+        "UMask": "0xf10",
+        "Unit": "CXLCM"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-interconnect.=
json
new file mode 100644
index 000000000000..b5723a69725a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-interconnect.json
@@ -0,0 +1,218 @@
+[
+    {
+        "BriefDescription": "UNC_SCA_RBT_INSERT.DATA_FWD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5B",
+        "EventName": "UNC_SCA_RBT_INSERT.DATA_FWD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "UNC_SCA_RBT_OCCUPANCY.DATA_FWD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x58",
+        "EventName": "UNC_SCA_RBT_OCCUPANCY.DATA_FWD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "Counts once per cache line access from HIOP w=
ith the opcode FsRdCur",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_FSRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_FSRDCUR",
+        "UMask": "0x23e0304",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "Counts once per cache line access from HIOP w=
ith the opcode ItoMWr_Opt",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_ITOMWR_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_ITOMWR_OPT",
+        "UMask": "0x3360304",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "Counts once per cache line access from HIOP w=
ith the opcode MemPushWr",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MEMPUSHWR",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MEMPUSHWR",
+        "UMask": "0x32e0304",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "Counts once per cache line access from HIOP w=
hich misses the cache with the opcode FsRdCur",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MISS_FSRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MISS_FSRDCUR",
+        "UMask": "0x23e0204",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "Counts once per cache line access from HIOP w=
hich misses the cache with the opcode ItoMWr_Opt",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MISS_ITOMWR_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MISS_ITOMWR_OPT=
",
+        "UMask": "0x3360204",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "Counts once per cache line access from HIOP w=
hich misses the cache with the opcode MemPushWr",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MISS_MEMPUSHWR",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MISS_MEMPUSHWR"=
,
+        "UMask": "0x32e0204",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "Counts once per cache line access from HIOP w=
hich misses the cache with the opcode SpecItoM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MISS_SPECITOM",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MISS_SPECITOM",
+        "UMask": "0x31e0204",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "Counts once per cache line access from HIOP w=
hich misses the cache with the opcode WCiLF",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MISS_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_MISS_WCILF",
+        "UMask": "0x21e0204",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "Counts once per cache line access from HIOP w=
ith the opcode SpecItoM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_SPECITOM",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_SPECITOM",
+        "UMask": "0x31e0304",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "Counts once per cache line access from HIOP w=
ith the opcode WCiLF",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_SCA_TOR_INSERTS.PRQ_HIOP_WCILF",
+        "UMask": "0x21e0304",
+        "Unit": "SCA"
+    },
+    {
+        "BriefDescription": "Agent to fabric requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0E",
+        "EventName": "UNC_UBR_UFI_A2F_TXN_COUNT.REQ",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_UBR_UFI_A2F_TXN_COUNT.REQ",
+        "UMask": "0xc000000f",
+        "Unit": "UBR"
+    },
+    {
+        "BriefDescription": "Agent to fabric responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0E",
+        "EventName": "UNC_UBR_UFI_A2F_TXN_COUNT.RSP",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_UBR_UFI_A2F_TXN_COUNT.RSP",
+        "UMask": "0xc0000047",
+        "Unit": "UBR"
+    },
+    {
+        "BriefDescription": "Agent to fabric snoops",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0E",
+        "EventName": "UNC_UBR_UFI_A2F_TXN_COUNT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_UBR_UFI_A2F_TXN_COUNT.SNP",
+        "UMask": "0xc0000017",
+        "Unit": "UBR"
+    },
+    {
+        "BriefDescription": "Agent to fabric writebacks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0E",
+        "EventName": "UNC_UBR_UFI_A2F_TXN_COUNT.WB",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_UBR_UFI_A2F_TXN_COUNT.WB",
+        "UMask": "0xc0000027",
+        "Unit": "UBR"
+    },
+    {
+        "BriefDescription": "Fabric to agent requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0D",
+        "EventName": "UNC_UBR_UFI_F2A_TXN_COUNT.REQ",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_UBR_UFI_F2A_TXN_COUNT.REQ",
+        "UMask": "0xf",
+        "Unit": "UBR"
+    },
+    {
+        "BriefDescription": "Fabric to agent responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0D",
+        "EventName": "UNC_UBR_UFI_F2A_TXN_COUNT.RSP",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_UBR_UFI_F2A_TXN_COUNT.RSP",
+        "UMask": "0x47",
+        "Unit": "UBR"
+    },
+    {
+        "BriefDescription": "Fabric to agent snoops",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0D",
+        "EventName": "UNC_UBR_UFI_F2A_TXN_COUNT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_UBR_UFI_F2A_TXN_COUNT.SNP",
+        "UMask": "0x17",
+        "Unit": "UBR"
+    },
+    {
+        "BriefDescription": "Fabric to agent writebacks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0D",
+        "EventName": "UNC_UBR_UFI_F2A_TXN_COUNT.WB",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_UBR_UFI_F2A_TXN_COUNT.WB",
+        "UMask": "0x27",
+        "Unit": "UBR"
+    },
+    {
+        "BriefDescription": "ULA Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_ULA_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ULA_CLOCKTICKS",
+        "Unit": "ULA"
+    },
+    {
+        "BriefDescription": "UNC_ULA_UFI_F2A_TXN_COUNT.DATA_CH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x09",
+        "EventName": "UNC_ULA_UFI_F2A_TXN_COUNT.DATA_CH",
+        "PerPkg": "1",
+        "UMask": "0x31007ffd",
+        "Unit": "ULA"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-io.json b/=
tools/perf/pmu-events/arch/x86/diamondrapids/uncore-io.json
new file mode 100644
index 000000000000..3f79e9b60073
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-io.json
@@ -0,0 +1,386 @@
+[
+    {
+        "BriefDescription": "Inbound Traffic Controller (ITC) received dat=
a for a write request targeting system memory.  Increments once per 4 bytes=
 of data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3B",
+        "EventName": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_ALL_PARTS",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_ALL_PARTS",
+        "UMask": "0x1ff001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "HIOP received data for a write request target=
ing system memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3B",
+        "EventName": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART0",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART0",
+        "UMask": "0x101001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "HIOP received data for a write request target=
ing system memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3B",
+        "EventName": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART1",
+        "UMask": "0x102001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "HIOP received data for a write request target=
ing system memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3B",
+        "EventName": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART2",
+        "UMask": "0x104001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "HIOP received data for a write request target=
ing system memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3B",
+        "EventName": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART3",
+        "UMask": "0x108001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "HIOP received data for a write request target=
ing system memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3B",
+        "EventName": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART4",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART4",
+        "UMask": "0x110001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "HIOP received data for a write request target=
ing system memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3B",
+        "EventName": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART5",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART5",
+        "UMask": "0x120001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "HIOP received data for a write request target=
ing system memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3B",
+        "EventName": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART6",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART6",
+        "UMask": "0x140001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "HIOP received data for a write request target=
ing system memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3B",
+        "EventName": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART7",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_MEM.MWR_POSTED_PART7",
+        "UMask": "0x180001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller (ITC) received dat=
a for a P2P completion.  Counts on the HIOP stack containing the device sen=
ding the read completion.  Increments once per 4 bytes of data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.CPL_ALL_PARTS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.CPL_ALL_PARTS",
+        "UMask": "0x4ff007",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part0.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.CPL_PART0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.CPL_PART0",
+        "UMask": "0x401007",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part1.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.CPL_PART1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.CPL_PART1",
+        "UMask": "0x402007",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part2.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.CPL_PART2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.CPL_PART2",
+        "UMask": "0x404007",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part3.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.CPL_PART3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.CPL_PART3",
+        "UMask": "0x408007",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part4.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.CPL_PART4",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.CPL_PART4",
+        "UMask": "0x410007",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part5.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.CPL_PART5",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.CPL_PART5",
+        "UMask": "0x420007",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part6.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.CPL_PART6",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.CPL_PART6",
+        "UMask": "0x440007",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part7.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.CPL_PART7",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.CPL_PART7",
+        "UMask": "0x480007",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller (ITC) received dat=
a for a P2P write.  Counts on the HIOP stack containing the device issuing =
the peer write.  Increments once per 4 bytes of data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_ALL_PARTS",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_ALL_PARTS",
+        "UMask": "0x1ff001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part0.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART0",
+        "UMask": "0x101001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part1.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART1",
+        "UMask": "0x102001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part2.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART2",
+        "UMask": "0x104001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part3.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART3",
+        "UMask": "0x108001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part4.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART4",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART4",
+        "UMask": "0x110001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part5.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART5",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART5",
+        "UMask": "0x120001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part6.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART6",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART6",
+        "UMask": "0x140001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "Inbound Traffic Controller received data for =
a P2P transaction from Part7.  Each increment represents 4 bytes of data (T=
ODO: check).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART7",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ITC_INB_DATA_P2P.MWR_POSTED_PART7",
+        "UMask": "0x180001",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "UNC_ITC_SFI0_DAT_INSERTS.CPL_ALL_PARTS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_ITC_SFI0_DAT_INSERTS.CPL_ALL_PARTS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4ff000",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x401000",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x402000",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x404000",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x408000",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART4",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x410000",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART5",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x420000",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART6",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x440000",
+        "Unit": "ITC"
+    },
+    {
+        "BriefDescription": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_ITC_SFI0_DAT_INSERTS.CPL_PART7",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x480000",
+        "Unit": "ITC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-memory.jso=
n b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-memory.json
new file mode 100644
index 000000000000..5b5eafaa658d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/uncore-memory.json
@@ -0,0 +1,939 @@
+[
+    {
+        "BriefDescription": "Increments once per HAMVF clock.  HAMVF is in=
 the memory fabric domain.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_HAMVF_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_CLOCKTICKS",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Updates to HAMVF's IO Snoop Filter",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_HAMVF_HSF_OPERATIONS.IOCAHP_UPDATE",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_HSF_OPERATIONS.IOCAHP_UPDATE",
+        "UMask": "0x3ffff8007e",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Counts once per lookup to the local IA snoop =
filter which results in a hit.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_HAMVF_HSF_OPERATIONS.LOCAL_IA_LOOKUP_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_HSF_OPERATIONS.LOCAL_IA_LOOKUP_HIT=
",
+        "UMask": "0x3ffff81f35",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Counts once per lookup to the local IA snoop =
filter which results in a miss.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_HAMVF_HSF_OPERATIONS.LOCAL_IA_LOOKUP_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_HSF_OPERATIONS.LOCAL_IA_LOOKUP_MIS=
S",
+        "UMask": "0x3ffff800b5",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Counts once per update to the local IA snoop =
filter.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_HAMVF_HSF_OPERATIONS.LOCAL_IA_UPDATE",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_HSF_OPERATIONS.LOCAL_IA_UPDATE",
+        "UMask": "0x3ffff80075",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Snoops sent from HAMVF to a local IA agent du=
e to capacity",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_HAMVF_SNOOPS_SENT.LOCAL_IACA_CAPACITY",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_SNOOPS_SENT.LOCAL_IACA_CAPACITY",
+        "UMask": "0x15",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Snoops sent from HAMVF to a local IA agent du=
e to another agent's snoop request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_HAMVF_SNOOPS_SENT.LOCAL_IACA_DEMAND",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_SNOOPS_SENT.LOCAL_IACA_DEMAND",
+        "UMask": "0x16",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Snoops sent from HAMVF to a local IO agent du=
e to capacity",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_HAMVF_SNOOPS_SENT.LOCAL_IOCA_CAPACITY",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_SNOOPS_SENT.LOCAL_IOCA_CAPACITY",
+        "UMask": "0x19",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Snoops sent from HAMVF to a local IO agent du=
e to another agent's snoop request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_HAMVF_SNOOPS_SENT.LOCAL_IOCA_DEMAND",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_SNOOPS_SENT.LOCAL_IOCA_DEMAND",
+        "UMask": "0x1a",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Read operation which hits near memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_HAMVF_TAG_HIT.RD",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_TAG_HIT.RD",
+        "UMask": "0x3",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Read operation which resulted in a tag hit wi=
th near memory matching far memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_HAMVF_TAG_HIT.RD_CLEAN",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_TAG_HIT.RD_CLEAN",
+        "UMask": "0x1",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Read operation which resulted in a tag hit wi=
th near memory different than far memory.  A swap would be required to repl=
ace this line in near memory.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_HAMVF_TAG_HIT.RD_DIRTY",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_TAG_HIT.RD_DIRTY",
+        "UMask": "0x2",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "Read operation which hits far memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_HAMVF_TAG_MISS.RD",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_HAMVF_TAG_MISS.RD",
+        "UMask": "0x3",
+        "Unit": "HAMVF"
+    },
+    {
+        "BriefDescription": "All activation commands",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_ACT_COUNT.ALL",
+        "UMask": "0xc3",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Activate due to read",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.RD",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_ACT_COUNT.RD",
+        "UMask": "0xc1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Activate due to write",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.WR",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_ACT_COUNT.WR",
+        "UMask": "0xc2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Column Access Strobe for all reads and w=
rites",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_CAS_COUNT.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_CAS_COUNT.ALL",
+        "UMask": "0xcf",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Column Access Strobe for Read with Auto =
Precharge",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_CAS_COUNT.ALL_PRE_REG",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_CAS_COUNT.ALL_PRE_REG",
+        "UMask": "0xcc",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Column Access Strobe for all Reads",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_CAS_COUNT.RD",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_CAS_COUNT.RD",
+        "UMask": "0xc5",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Column Access Strobe for all Writes",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_CAS_COUNT.WR",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_CAS_COUNT.WR",
+        "UMask": "0xca",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "IMC Clockticks at mc_clk frequency (1/8th of =
DDR5 frequency and 1/16th of MCR frequency)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_CLOCKTICKS",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Precharge due to read, write, or PGT.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_PRE_COUNT.ALL",
+        "UMask": "0xc7",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Precharge due to page idle timer expiration",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.PGT",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_PRE_COUNT.PGT",
+        "UMask": "0xc4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Precharge due to read on page miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.RD",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_PRE_COUNT.RD",
+        "UMask": "0xc1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Precharge due to write on page miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.WR",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_PRE_COUNT.WR",
+        "UMask": "0xc2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Total Read Tracker Inserts",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M_TRKR_RD_INSERT_TYPE.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_TRKR_RD_INSERT_TYPE.ALL",
+        "UMask": "0xc0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Total Read Tracker Queue Occupancy",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M_TRKR_RD_OCCUPANCY_TYPE.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_TRKR_RD_OCCUPANCY_TYPE.ALL",
+        "UMask": "0xc0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Counts all writes inserted into the write tra=
cker.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xE8",
+        "EventName": "UNC_M_TRKR_WR_INSERT_TYPE.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_TRKR_WR_INSERT_TYPE.ALL",
+        "UMask": "0xc0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Counts once per 64 bytes of completion data s=
ent back to a PCIE device in response to a read targeting coherent memory."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA.CPL_ALL_PARTS",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA.CPL_ALL_PARTS",
+        "UMask": "0x4ff000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion data for Part0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA.CPL_PART0",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA.CPL_PART0",
+        "UMask": "0x401000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion data for Part1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA.CPL_PART1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA.CPL_PART1",
+        "UMask": "0x402000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion data for Part2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA.CPL_PART2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA.CPL_PART2",
+        "UMask": "0x404000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion data for Part3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA.CPL_PART3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA.CPL_PART3",
+        "UMask": "0x408000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion data for Part4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA.CPL_PART4",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA.CPL_PART4",
+        "UMask": "0x410000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion data for Part5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA.CPL_PART5",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA.CPL_PART5",
+        "UMask": "0x420000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion data for Part6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA.CPL_PART6",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA.CPL_PART6",
+        "UMask": "0x440000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion data for Part7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA.CPL_PART7",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA.CPL_PART7",
+        "UMask": "0x480000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Data Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART0",
+        "UMask": "0x401000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Data Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART1",
+        "UMask": "0x402000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Data Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART2",
+        "UMask": "0x404000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Data Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART3",
+        "UMask": "0x408000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Data Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART4",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART4",
+        "UMask": "0x410000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Data Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART5",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART5",
+        "UMask": "0x420000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Data Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART6",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART6",
+        "UMask": "0x440000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Data Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART7",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_DATA_OCCUPANCY.CPL_PART7",
+        "UMask": "0x480000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Counts once per completion sent back to a PCI=
E device in response to a read targeting coherent memory.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR.CPL_ALL_PARTS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR.CPL_ALL_PARTS",
+        "UMask": "0x4ff000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion headers for Part0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR.CPL_PART0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR.CPL_PART0",
+        "UMask": "0x401000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion headers for Part1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR.CPL_PART1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR.CPL_PART1",
+        "UMask": "0x402000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion headers for Part2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR.CPL_PART2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR.CPL_PART2",
+        "UMask": "0x404000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion headers for Part3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR.CPL_PART3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR.CPL_PART3",
+        "UMask": "0x408000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion headers for Part4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR.CPL_PART4",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR.CPL_PART4",
+        "UMask": "0x410000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion headers for Part5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR.CPL_PART5",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR.CPL_PART5",
+        "UMask": "0x420000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion headers for Part6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR.CPL_PART6",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR.CPL_PART6",
+        "UMask": "0x440000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Completion headers for Part7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR.CPL_PART7",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR.CPL_PART7",
+        "UMask": "0x480000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Header Buffer Occupancy=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART0",
+        "UMask": "0x401000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Header Buffer Occupancy=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART1",
+        "UMask": "0x402000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Header Buffer Occupancy=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART2",
+        "UMask": "0x404000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Header Buffer Occupancy=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART3",
+        "UMask": "0x408000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Header Buffer Occupancy=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART4",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART4",
+        "UMask": "0x410000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Header Buffer Occupancy=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART5",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART5",
+        "UMask": "0x420000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Header Buffer Occupancy=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART6",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART6",
+        "UMask": "0x440000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "Count Dram Completion Header Buffer Occupancy=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART7",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_DRAM_CPL_HDR_OCCUPANCY.CPL_PART7",
+        "UMask": "0x480000",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent an outbound header for a posted wri=
te P2P packet",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART0",
+        "UMask": "0x101001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent an outbound header for a posted wri=
te P2P packet",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART1",
+        "UMask": "0x102001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent an outbound header for a posted wri=
te P2P packet",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART2",
+        "UMask": "0x104001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent an outbound header for a posted wri=
te P2P packet",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART3",
+        "UMask": "0x108001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent an outbound header for a posted wri=
te P2P packet",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART4",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART4",
+        "UMask": "0x110001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent an outbound header for a posted wri=
te P2P packet",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART5",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART5",
+        "UMask": "0x120001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent an outbound header for a posted wri=
te P2P packet",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART6",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART6",
+        "UMask": "0x140001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent an outbound header for a posted wri=
te P2P packet",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART7",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_P2P.MWR_POSTED_PART7",
+        "UMask": "0x180001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a non-posted UXI-ini=
tiated (core-initiated) MRD request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_ALL_PARTS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_ALL_P=
ARTS",
+        "UMask": "0x2ff001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) MRD request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART0=
",
+        "UMask": "0x201001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) MWR request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART1=
",
+        "UMask": "0x202001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) ENQ request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART2=
",
+        "UMask": "0x204001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) CFG_RD request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART3=
",
+        "UMask": "0x208001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) CFG_WR request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART4",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART4=
",
+        "UMask": "0x210001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) IO_RD request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART5",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART5=
",
+        "UMask": "0x220001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) IO_WR request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART6",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART6=
",
+        "UMask": "0x240001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) Other request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART7",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MRD_NON_POSTED_PART7=
",
+        "UMask": "0x280001",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a non-posted UXI-ini=
tiated (core-initiated) MRD request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_ALL_PARTS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_ALL_PARTS=
",
+        "UMask": "0x1ff002",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) MRD request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART0",
+        "UMask": "0x101002",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) MWR request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART1",
+        "UMask": "0x102002",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) ENQ request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART2",
+        "UMask": "0x104002",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) CFG_RD request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART3",
+        "UMask": "0x108002",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) CFG_WR request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART4",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART4",
+        "UMask": "0x110002",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) IO_RD request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART5",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART5",
+        "UMask": "0x120002",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) IO_WR request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART6",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART6",
+        "UMask": "0x140002",
+        "Unit": "OTC"
+    },
+    {
+        "BriefDescription": "HIOP sent the header for a posted UXI-initiat=
ed (core-initiated) Other request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART7",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_OTC_OUTB_HDR_UXIREQ.MWR_POSTED_PART7",
+        "UMask": "0x180002",
+        "Unit": "OTC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/diamondrapids/virtual-memory.js=
on b/tools/perf/pmu-events/arch/x86/diamondrapids/virtual-memory.json
new file mode 100644
index 000000000000..169ff99c29f6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/diamondrapids/virtual-memory.json
@@ -0,0 +1,266 @@
+[
+    {
+        "BriefDescription": "Loads that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x320"
+    },
+    {
+        "BriefDescription": "Loads that miss the DTLB and hit the STLB. Ac=
count for 1G pages only",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT_1G",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB). Account for 1G pages only",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x200"
+    },
+    {
+        "BriefDescription": "Loads that miss the DTLB and hit the STLB. Ac=
count for 2M pages only",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT_2M",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB). Account for 2M pages only",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x100"
+    },
+    {
+        "BriefDescription": "Loads that miss the DTLB and hit the STLB. Ac=
count for 4K pages only",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT_4K",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB). Account for 4K pages only",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a demand load.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 1G page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 2M/4M page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 4K page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for a demand=
 load in the PMH each cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Stores that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x320"
+    },
+    {
+        "BriefDescription": "Stores that miss the DTLB and hit the STLB. A=
ccount for 1G pages only",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT_1G",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB). Account for 1G pages only",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x200"
+    },
+    {
+        "BriefDescription": "Stores that miss the DTLB and hit the STLB. A=
ccount for 2M pages only",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT_2M",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB). Account for 2M pages only",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x100"
+    },
+    {
+        "BriefDescription": "Stores that miss the DTLB and hit the STLB. A=
ccount for 4K pages only",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT_4K",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB). Account for 4K pages only",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a store.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 1G page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 2M/4M page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 4K page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for a store =
in the PMH each cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Instruction fetch requests that miss the ITLB=
 and hit the STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.STLB_HIT",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x120"
+    },
+    {
+        "BriefDescription": "Instruction fetch requests that miss the ITLB=
 and hit the STLB. Account for 2M pages only.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.STLB_HIT_2M",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB). Account for=
 2M pages only.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x100"
+    },
+    {
+        "BriefDescription": "Instruction fetch requests that miss the ITLB=
 and hit the STLB. Account for 4K pages only.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.STLB_HIT_4K",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB). Account for=
 4K pages only.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for code (instruction fetch) request.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_ACTIVE",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (1G)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_1G",
+        "PublicDescription": "Counts completed page walks (1G page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for an outst=
anding code request in the PMH each cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 7011fb91c882..87fa8a7c2f8d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -8,6 +8,7 @@ GenuineIntel-6-56,v12,broadwellde,core
 GenuineIntel-6-4F,v23,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.25,cascadelakex,core
 GenuineIntel-6-DD,v1.04,clearwaterforest,core
+GenuineIntel-19-1,v1.00,diamondrapids,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.25,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
--=20
2.56.1.708.g77570a6a1d-goog

