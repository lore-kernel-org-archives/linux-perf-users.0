Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6E198A35;
	Thu,  5 Sep 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537625; cv=none; b=ohpJD3VzbCGWVs9LnW5ID8X35aeX1V2s03vc1GBhr4WbD4tLP0nT9l3c/u0/lv1RktSIKTTlLSHlNfOAIhLmvCmx4IQpOMmVv6SK/wS+d/WHPd/E1+Q9nXAQBMX9YFiqnnYM1Ywfw7gCyApjs32DxuTH2SYaWUY2kncvav4FBp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537625; c=relaxed/simple;
	bh=RIkzm8s+UqO9ZE+38HTFnfVOxc5zFK1dr9ab+2KoDs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3g/d+YZOakxm8uswzBCqKgVJGJ/q2ocqnn/67Dvd0pDVTUHuSYta8LwsqbqMX/LxKFJgdNQIAXhqyzcq+aHhhKze/KrmjQcMxpdJnG3rjUVQoZPGS3NRoE03GN3ywxJN+iN9IItS0nBAzbqQhCRn7+p/H5IaoOs8vMFcJIEFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrmxIsHh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrmxIsHh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725537623; x=1757073623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RIkzm8s+UqO9ZE+38HTFnfVOxc5zFK1dr9ab+2KoDs8=;
  b=QrmxIsHhpdXxWTmEfhGGJsPVlJpzKsHaRCZ8jYWBzVy5EG85neI3TmIS
   XGNH8lEYom9IFi3eUAsGpsNkbHOaVmRnkXNbfx1qYlkiMf7nBHT7pUNrO
   x2wyFZzllGjcWG649pau0I02ETzBa3wyYxlBeFjpcXMqibhP/AKx36Pfw
   BLY6XfckEYDFT8R5RdSS4uR6VvI72y+QIr+EHozI+RoG6DM0O9fVW+WrB
   P4TWfqzrDcRTsbQfHzZF/cC3OGgEeSMjxEyMKc6dtQIAXrNukviW+U8aM
   fNfNkFXeOZ2TsjZ04fHqLAwigqCKU6WPJleDA9X2XLg6ONa2ppKBAeRs7
   A==;
X-CSE-ConnectionGUID: y2KsRjvLSnqdmCdoJY6tBw==
X-CSE-MsgGUID: TeuL+pMgRz6nJXD9b/DUYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27169828"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="27169828"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:00:22 -0700
X-CSE-ConnectionGUID: 29OoTbtNQqeIduw2pmf4gw==
X-CSE-MsgGUID: 1+LwMTQhRL2kWWH9xPGzFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70196418"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.96.163])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:00:17 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/x86/intel/pt: Fix buffer full but size is 0 case
Date: Thu,  5 Sep 2024 15:00:07 +0300
Message-ID: <20240905120007.11943-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

If the trace data buffer becomes full, a truncated flag [T] is reported
in PERF_RECORD_AUX.  In some cases, the size reported is 0, even though
data must have been added to make the buffer full.

That happens when the buffer fills up from empty to full before the
Intel PT driver has updated the buffer position.  Then the driver
calculates the new buffer position before calculating the data size.
If the old and new positions are the same, the data size is reported
as 0, even though it is really the whole buffer size.

Fix by detecting when the buffer position is wrapped, and adjust the
data size calculation accordingly.

Example

  Use a very small buffer size (8K) and observe the size of truncated [T]
  data. Before the fix, it is possible to see records of 0 size.

  Before:

    $ perf record -m,8K -e intel_pt// uname
    Linux
    [ perf record: Woken up 2 times to write data ]
    [ perf record: Captured and wrote 0.105 MB perf.data ]
    $ perf script -D --no-itrace | grep AUX | grep -F '[T]'
    Warning:
    AUX data lost 2 times out of 3!

    5 19462712368111 0x19710 [0x40]: PERF_RECORD_AUX offset: 0 size: 0 flags: 0x1 [T]
    5 19462712700046 0x19ba8 [0x40]: PERF_RECORD_AUX offset: 0x170 size: 0xe90 flags: 0x1 [T]

 After:

    $ perf record -m,8K -e intel_pt// uname
    Linux
    [ perf record: Woken up 3 times to write data ]
    [ perf record: Captured and wrote 0.040 MB perf.data ]
    $ perf script -D --no-itrace | grep AUX | grep -F '[T]'
    Warning:
    AUX data lost 2 times out of 3!

    1 113720802995 0x4948 [0x40]: PERF_RECORD_AUX offset: 0 size: 0x2000 flags: 0x1 [T]
    1 113720979812 0x6b10 [0x40]: PERF_RECORD_AUX offset: 0x2000 size: 0x2000 flags: 0x1 [T]

Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c | 11 ++++++++---
 arch/x86/events/intel/pt.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fd4670a6694e..a087bc0c5498 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -828,11 +828,13 @@ static void pt_buffer_advance(struct pt_buffer *buf)
 	buf->cur_idx++;
 
 	if (buf->cur_idx == buf->cur->last) {
-		if (buf->cur == buf->last)
+		if (buf->cur == buf->last) {
 			buf->cur = buf->first;
-		else
+			buf->wrapped = true;
+		} else {
 			buf->cur = list_entry(buf->cur->list.next, struct topa,
 					      list);
+		}
 		buf->cur_idx = 0;
 	}
 }
@@ -846,8 +848,11 @@ static void pt_buffer_advance(struct pt_buffer *buf)
 static void pt_update_head(struct pt *pt)
 {
 	struct pt_buffer *buf = perf_get_aux(&pt->handle);
+	bool wrapped = buf->wrapped;
 	u64 topa_idx, base, old;
 
+	buf->wrapped = false;
+
 	if (buf->single) {
 		local_set(&buf->data_size, buf->output_off);
 		return;
@@ -865,7 +870,7 @@ static void pt_update_head(struct pt *pt)
 	} else {
 		old = (local64_xchg(&buf->head, base) &
 		       ((buf->nr_pages << PAGE_SHIFT) - 1));
-		if (base < old)
+		if (base < old || (base == old && wrapped))
 			base += buf->nr_pages << PAGE_SHIFT;
 
 		local_add(base - old, &buf->data_size);
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index f5e46c04c145..a1b6c04b7f68 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -65,6 +65,7 @@ struct pt_pmu {
  * @head:	logical write offset inside the buffer
  * @snapshot:	if this is for a snapshot/overwrite counter
  * @single:	use Single Range Output instead of ToPA
+ * @wrapped:	buffer advance wrapped back to the first topa table
  * @stop_pos:	STOP topa entry index
  * @intr_pos:	INT topa entry index
  * @stop_te:	STOP topa entry pointer
@@ -82,6 +83,7 @@ struct pt_buffer {
 	local64_t		head;
 	bool			snapshot;
 	bool			single;
+	bool			wrapped;
 	long			stop_pos, intr_pos;
 	struct topa_entry	*stop_te, *intr_te;
 	void			**data_pages;
-- 
2.43.0

