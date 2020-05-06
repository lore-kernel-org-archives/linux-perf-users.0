From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/91] perf tools: Remove unneeded semicolons
Date: Wed,  6 May 2020 12:21:18 -0300
Message-ID: <20200506152234.21977-16-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Zou Wei <zou_wei@huawei.com>, Hulk Robot <hulkci@huawei.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

Fixes coccicheck warnings:

  tools/perf/builtin-diff.c:1565:2-3: Unneeded semicolon
  tools/perf/builtin-lock.c:778:2-3: Unneeded semicolon
  tools/perf/builtin-mem.c:126:2-3: Unneeded semicolon
  tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c:555:2-3: Unneeded semicolon
  tools/perf/util/ordered-events.c:317:2-3: Unneeded semicolon
  tools/perf/util/synthetic-events.c:1131:2-3: Unneeded semicolon
  tools/perf/util/trace-event-read.c:78:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/1588065523-71423-1-git-send-email-zou_wei@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c                               | 2 +-
 tools/perf/builtin-lock.c                               | 2 +-
 tools/perf/builtin-mem.c                                | 2 +-
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c | 2 +-
 tools/perf/util/ordered-events.c                        | 2 +-
 tools/perf/util/synthetic-events.c                      | 2 +-
 tools/perf/util/trace-event-read.c                      | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index c94a002f295e..59d40f036587 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1562,7 +1562,7 @@ hpp__entry_pair(struct hist_entry *he, struct hist_entry *pair,
 
 	default:
 		BUG_ON(1);
-	};
+	}
 }
 
 static void
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 474dfd59d7eb..543d82fec556 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -775,7 +775,7 @@ static void dump_threads(void)
 		pr_info("%10d: %s\n", st->tid, thread__comm_str(t));
 		node = rb_next(node);
 		thread__put(t);
-	};
+	}
 }
 
 static void dump_map(void)
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index a13f5817d6fc..68a7eb84561a 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -123,7 +123,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 
 		rec_argv[i++] = "-e";
 		rec_argv[i++] = perf_mem_events__name(j);
-	};
+	}
 
 	if (all_user)
 		rec_argv[i++] = "--all-user";
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index 0ccf10a0bf44..4ce109993e74 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -552,7 +552,7 @@ static int intel_pt_do_get_packet(const unsigned char *buf, size_t len,
 		break;
 	default:
 		break;
-	};
+	}
 
 	if (!(byte & BIT(0))) {
 		if (byte == 0)
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 359db2b1fcef..48c8f609441b 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -314,7 +314,7 @@ static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
 	case OE_FLUSH__NONE:
 	default:
 		break;
-	};
+	}
 
 	pr_oe_time(oe->next_flush, "next_flush - ordered_events__flush PRE  %s, nr_events %u\n",
 		   str[how], oe->nr_events);
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 1ea9adaef9c7..89b390623b63 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1181,7 +1181,7 @@ void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data, struct perf
 		synthesize_mask((struct perf_record_record_cpu_map *)data->data, map, max);
 	default:
 		break;
-	};
+	}
 }
 
 static struct perf_record_cpu_map *cpu_map_event__new(struct perf_cpu_map *map)
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 8593d3c200c6..f507dff713c9 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -75,7 +75,7 @@ static void skip(int size)
 		r = size > BUFSIZ ? BUFSIZ : size;
 		do_read(buf, r);
 		size -= r;
-	};
+	}
 }
 
 static unsigned int read4(struct tep_handle *pevent)
-- 
2.21.1
