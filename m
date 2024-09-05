Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B74581AB4
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549076; cv=none; b=spSF/vo13MJPOi4WCh42dt7+IUw1OE4zQ9timlN/DQpBtRsm6K7qhlYJC4IZPmDmpf0hUCzhBEu55InYkjLyAG3CNlwZ0F3sfpMaTaBBlUPZa7BtRzwN4m9mDTXIVwNwv9hmtJMbnmnDPJu/nDv2hzksUl0iknPP8WUo5T//kBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549076; c=relaxed/simple;
	bh=8EUy+uWoFD0IwnNkZ/PQt80d580Vc3g6YzkjdkPDaV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCeHYeoW7aAImHdKq8kNfrr+biSUqepKJBEMf7VzWBt+u3XjgMsg3nUDxr983NXhtyf4zFtALlijqbIji9mU1oL2LMdjXjDabKBjB9iST0V8TDGg2zpfd8crwBn4n7j+B2Tll2p8/2TUZ1Veu9mYgNs/mAvKkP5gz4FVnhuKa34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgpTm3m5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgpTm3m5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549074; x=1757085074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8EUy+uWoFD0IwnNkZ/PQt80d580Vc3g6YzkjdkPDaV4=;
  b=CgpTm3m51frHk2fNhSqMdJEtitCCJ/vLX3ozaFErRDJdrsNkDNEqhbl2
   huBagyp9a85MBBIh6J0ZT8+y33lQWijv6p52M3xMakvA6ezJR3jUhQ/8z
   P2T+5QKtMuJcRwgPaXJERZsMY3PiUoKED5xfgw29FC3iHU/EVa+Xhbi8C
   SCTpWEi/P8O+ym/3CuRJSkcA2FwNf6LSYn/aDya2W7yZ8/p9ixsiKSZzZ
   ut3ceiC8l9fpgQiv+uhu/sihL4+FUiKYzTHQyoe+h+ZjW30PZcLSG0tRT
   DxJuhOjUGphCFKc3wZAphMczY3Lj4I4hjMWwe8q6k8y2sg6PsVjhykEEX
   g==;
X-CSE-ConnectionGUID: XLWfpWdzSISVeOZNEzsfIQ==
X-CSE-MsgGUID: ADR2gEESSDWH1v5L3KAGOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49688970"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49688970"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
X-CSE-ConnectionGUID: BGR+mbyuRrebxInO12tuqA==
X-CSE-MsgGUID: CFWZ+thNQNC2d0PjP+l+nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70456096"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	namhyung@kernel.org,
	acme@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 01/10] perf: Avoid buffer overflow in python register interface
Date: Thu,  5 Sep 2024 08:07:55 -0700
Message-ID: <20240905151058.2127122-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905151058.2127122-1-ak@linux.intel.com>
References: <20240905151058.2127122-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running a script that processes PEBS records gives buffer overflows
in valgrind. The problem is that the allocation of the register
string doesn't include the terminating 0 byte. Fix this. I also replaced
the very magic "28" with a more reasonable larger buffer that should
fit all registers. There's no need to conserve memory here.

==2106591== Memcheck, a memory error detector
==2106591== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==2106591== Using Valgrind-3.22.0 and LibVEX; rerun with -h for copyright info
==2106591== Command: ../perf script -i tcall.data gcov.py tcall.gcov
==2106591==
==2106591== Invalid write of size 1
==2106591==    at 0x713354: regs_map (trace-event-python.c:748)
==2106591==    by 0x7134EB: set_regs_in_dict (trace-event-python.c:784)
==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
==2106591==  Address 0x7186fe0 is 0 bytes after a block of size 0 alloc'd
==2106591==    at 0x484280F: malloc (vg_replace_malloc.c:442)
==2106591==    by 0x7134AD: set_regs_in_dict (trace-event-python.c:780)
==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
==2106591==
==2106591== Invalid read of size 1
==2106591==    at 0x484B6C6: strlen (vg_replace_strmem.c:502)
==2106591==    by 0x555D494: PyUnicode_FromString (unicodeobject.c:1899)
==2106591==    by 0x7134F7: set_regs_in_dict (trace-event-python.c:786)
==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
==2106591==  Address 0x7186fe0 is 0 bytes after a block of size 0 alloc'd
==2106591==    at 0x484280F: malloc (vg_replace_malloc.c:442)
==2106591==    by 0x7134AD: set_regs_in_dict (trace-event-python.c:780)
==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
==2106591==
==2106591== Invalid write of size 1
==2106591==    at 0x713354: regs_map (trace-event-python.c:748)
==2106591==    by 0x713539: set_regs_in_dict (trace-event-python.c:789)
==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
==2106591==  Address 0x7186fe0 is 0 bytes after a block of size 0 alloc'd
==2106591==    at 0x484280F: malloc (vg_replace_malloc.c:442)
==2106591==    by 0x7134AD: set_regs_in_dict (trace-event-python.c:780)
==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
==2106591==
==2106591== Invalid read of size 1
==2106591==    at 0x484B6C6: strlen (vg_replace_strmem.c:502)
==2106591==    by 0x555D494: PyUnicode_FromString (unicodeobject.c:1899)
==2106591==    by 0x713545: set_regs_in_dict (trace-event-python.c:791)
==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
==2106591==  Address 0x7186fe0 is 0 bytes after a block of size 0 alloc'd
==2106591==    at 0x484280F: malloc (vg_replace_malloc.c:442)
==2106591==    by 0x7134AD: set_regs_in_dict (trace-event-python.c:780)
==2106591==    by 0x713E58: get_perf_sample_dict (trace-event-python.c:940)
==2106591==    by 0x716327: python_process_general_event (trace-event-python.c:1499)
==2106591==    by 0x7164E1: python_process_event (trace-event-python.c:1531)
==2106591==    by 0x44F9AF: process_sample_event (builtin-script.c:2549)
==2106591==    by 0x6294DC: evlist__deliver_sample (session.c:1534)
==2106591==    by 0x6296D0: machines__deliver_event (session.c:1573)
==2106591==    by 0x629C39: perf_session__deliver_event (session.c:1655)
==2106591==    by 0x625830: ordered_events__deliver_event (session.c:193)
==2106591==    by 0x630B23: do_flush (ordered-events.c:245)
==2106591==    by 0x630E7A: __ordered_events__flush (ordered-events.c:324)
==2106591==
73056 total, 29 ignored

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 .../perf/util/scripting-engines/trace-event-python.c  | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 6971dd6c231f..d7183134b669 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -762,6 +762,8 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
 	}
 }
 
+#define MAX_REG_SIZE 128
+
 static int set_regs_in_dict(PyObject *dict,
 			     struct perf_sample *sample,
 			     struct evsel *evsel)
@@ -769,14 +771,7 @@ static int set_regs_in_dict(PyObject *dict,
 	struct perf_event_attr *attr = &evsel->core.attr;
 	const char *arch = perf_env__arch(evsel__env(evsel));
 
-	/*
-	 * Here value 28 is a constant size which can be used to print
-	 * one register value and its corresponds to:
-	 * 16 chars is to specify 64 bit register in hexadecimal.
-	 * 2 chars is for appending "0x" to the hexadecimal value and
-	 * 10 chars is for register name.
-	 */
-	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
+	int size = (__sw_hweight64(attr->sample_regs_intr) * MAX_REG_SIZE) + 1;
 	char *bf = malloc(size);
 	if (!bf)
 		return -1;
-- 
2.45.2

