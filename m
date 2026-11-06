Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931639;
	b=fp87zNG1GOiXLwjmXLW64Ani4YSEUyAmojyYgfOEAgZb8PG8sT2nSNewCZZNq4FvgRhV
	 wdBuhRzvhaRkfKECUG2NHFfblI4hlfmE7iQd4ublZtu7V4Ph0Ochtd7zKrzIydO0TPG3d
	 2lm05IXEW5PSNkpWwvOQe3Z5uM832hoJphkBExV3CL+UP5t22WMnZ4VK9nuCvN1bcm35S
	 CK0GfB29aSfXGq9TByIqqMXoOMbO+YHE22wW//auUWi+SaCDRCyl9K0/KoofrIFyspZR3
	 cFTk6o8HbX22vQjX6ddepJCJICrgVvelvFpDqGS1hM1c5Lhni3pgHqFTb1VGyxoijDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931639;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 DKIM-Signature;
	bh=zm+SMFNSAHOaRmQ0QltCE96ATz80uT68/NyBBkY0tag=;
	b=A1zGLEh67JJvgsr/07bjALi3tVcHfl7lu0JEKL09FRo6VHd4x6zuQ8aMA+ZOJIpvv+Ul
	 ySJAv9x0jNXjKUKIJR7k2A0WeYsXqWkB2VqIS9Efcg2oFN5SqJ1gN6wjDeDisqqWG8Sg2
	 jMyoF5nhSlO2KEscAb/X2nVXJCB2wSJCtC0a+YwMsyCpu7xbu3PTy9W27hWSjMVoHZ7PN
	 39UH6Md+wfFP1yUp9NYIH9BiQDx8M+qpvbmTFRGz1lWktsKjZH4uIOtRcgfRUqIixD+Xe
	 0ZhB67Kh7voXRm5XfZIZ0e94wForoUj4x+VVY9CuxX9c9gzoZPIq24Gt4RcvgzOL6oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=dakSFfV2;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B05BB606A32E;
	Fri,  6 Nov 2026 02:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B05BB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=dakSFfV2
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Li RongQing <lirongqing@baidu.com>,
	Alexander Antonov <alexander.antonov@linux.intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf iostat: Reject incomplete and out-of-range port strings
Date: Fri, 6 Nov 2026 10:20:27 +0800
Message-ID: <20261106022027.2413-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793931636;
	bh=zm+SMFNSAHOaRmQ0QltCE96ATz80uT68/NyBBkY0tag=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=dakSFfV2e9dvwZhUIYMSjcmfGM1PKhdRTApKGp5Dq4GwjDv84RZsguLhLMtZro7/O
	 CYYbplvxpXujNoE7gukAkd6MFtefKHo8dkCl3bDbq6EAgECnRQPykAw/o6DSs1t+mf
	 2ZzcNrBbmKWWf9gJrPo694Ds+A/dzSqGpFhvq6l/IEhEflRU9VYfpdUM//nc27XZr+
	 fcvdN/wjFFAEOoD8TY7i1gMzAOkGPkag9WZk2LlE3JYOYNi4wg3Xg6bLEowdj7pqtT
	 txrgiI1fU78ukQ93AoSy7a8ilzWrS3Yj4GcRs/nDBzaK0JhPFZ0+WqZrLYd9pWktz/
	 VTSDUmCXzz0Dg==

From: Li RongQing <lirongqing@baidu.com>

The root port regular expression accepts trailing characters and an
unbounded domain field. A nine-digit domain matches it but makes the
subsequent width-limited sscanf() stop before the bus. The parser still
returns success, allowing the filter to use an uninitialized or stale
bus value. A three-digit bus is silently truncated as well.

Match the complete notation within the documented domain and bus widths.
Check regular expression compilation and propagate conversion failures
instead of treating a warning as successful parsing.

Fixes: f9ed693e8bc0 ("perf stat: Enable iostat mode for x86 platforms")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 tools/perf/arch/x86/util/iostat.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index f8b4939..7dc31f5 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -251,9 +251,14 @@ static int iio_root_port_parse_str(u32 *domain, u8 *bus, char *str)
 	 * Valid bus range [0:ff]
 	 * Example: 0000:af, 0:3d, 01:7
 	 */
-	regcomp(&regex, "^([a-f0-9A-F]{1,}):([a-f0-9A-F]{1,2})", REG_EXTENDED);
+	ret = regcomp(&regex, "^([a-f0-9A-F]{1,4}):([a-f0-9A-F]{1,2})$",
+		      REG_EXTENDED);
+	if (ret)
+		return ret;
 	ret = regexec(&regex, str, 0, NULL, 0);
-	if (ret || sscanf(str, "%08x:%02hhx", domain, bus) != 2)
+	if (!ret && sscanf(str, "%04x:%02hhx", domain, bus) != 2)
+		ret = -EINVAL;
+	if (ret)
 		pr_warning("Unrecognized root port format: %s\n"
 			   "Please use the following format:\n"
 			   "\t [domain]:[bus]\n"
-- 
2.9.4

