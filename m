From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 7/7] perf evsel: Use hweight64() instead of hweight_long(attr.sample_regs_user)
Date: Fri, 12 Apr 2019 11:22:50 -0300
Message-ID: <20190412142250.20595-8-acme@kernel.org>
References: <20190412142250.20595-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412142250.20595-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mao Han <han_mao@c-sky.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mao Han <han_mao@c-sky.com>

On 32-bits platform with more than 32 registers, the 64 bits mask is
truncate to the lower 32 bits and the return value of hweight_long will
always smaller than 32. When kernel outputs more than 32 registers, but
the user perf program only counts 32, there will be a data mismatch
result to overflow check fail.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Fixes: 6a21c0b5c2ab ("perf tools: Add core support for sampling intr machine state regs")
Fixes: d03f2170546d ("perf tools: Expand perf_event__synthesize_sample()")
Fixes: 0f6a30150ca2 ("perf tools: Support user regs and stack in sample parsing")
Link: http://lkml.kernel.org/r/29ad7947dc8fd1ff0abd2093a72cc27a2446be9f.1554883878.git.han_mao@c-sky.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66d066f18b5b..966360844fff 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2368,7 +2368,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		if (data->user_regs.abi) {
 			u64 mask = evsel->attr.sample_regs_user;
 
-			sz = hweight_long(mask) * sizeof(u64);
+			sz = hweight64(mask) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->user_regs.mask = mask;
 			data->user_regs.regs = (u64 *)array;
@@ -2424,7 +2424,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		if (data->intr_regs.abi != PERF_SAMPLE_REGS_ABI_NONE) {
 			u64 mask = evsel->attr.sample_regs_intr;
 
-			sz = hweight_long(mask) * sizeof(u64);
+			sz = hweight64(mask) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->intr_regs.mask = mask;
 			data->intr_regs.regs = (u64 *)array;
@@ -2552,7 +2552,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_REGS_USER) {
 		if (sample->user_regs.abi) {
 			result += sizeof(u64);
-			sz = hweight_long(sample->user_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -2580,7 +2580,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
 			result += sizeof(u64);
-			sz = hweight_long(sample->intr_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -2710,7 +2710,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_REGS_USER) {
 		if (sample->user_regs.abi) {
 			*array++ = sample->user_regs.abi;
-			sz = hweight_long(sample->user_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
 			memcpy(array, sample->user_regs.regs, sz);
 			array = (void *)array + sz;
 		} else {
@@ -2746,7 +2746,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
 			*array++ = sample->intr_regs.abi;
-			sz = hweight_long(sample->intr_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
 			memcpy(array, sample->intr_regs.regs, sz);
 			array = (void *)array + sz;
 		} else {
-- 
2.20.1
