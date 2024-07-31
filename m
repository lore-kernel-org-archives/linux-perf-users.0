Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A593016EC06;
	Wed, 31 Jul 2024 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470109; cv=none; b=as7Tbft8dnawUVowcWN0+O1sSamurO9cWIo+D/0jnoVefW1IkZWBMURW1FYlvWEiQleB66Nm8xlNCbbMMh9QqUs0X6FsSaJcrDrIWliJbpIGxa3NqdUlZTjtv3cKWaS0lCb5vsnGoxoBmI4TG/HTCoahbYaP9r0q6/vP3KXYRGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470109; c=relaxed/simple;
	bh=hLDVUUQ8aoLWqfdvlHVB0OV5dix+CmkyyetPRs7HfM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzBDImni1BNoD1HRnVB16Ala4hUUUe8CTKek3z+JZ0OTCfzQCIc6UowdvAZLRbfHAIS5dipDuTOOEzKGaqb4HprVpXyN74NinAP2k2jWMnukALQzzglYCq9cbilKjEBfxvjOzRnZ7KKXQ0VQ7oH3Mrx4l7L+7zyK3QyM88WUmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGcOLNyh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGcOLNyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C76C4AF11;
	Wed, 31 Jul 2024 23:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470109;
	bh=hLDVUUQ8aoLWqfdvlHVB0OV5dix+CmkyyetPRs7HfM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGcOLNyhv6EQ3gMqDkSecsS//k5rPTs9AO1wjaDnJ5ken/WEjm8uXU0Q8EvKb3kGg
	 WCDRr/xAxLfDUhYFlZpju5fTFNAfC6Vx1K4Y+rUhLax6X0mZmIgzL9u3TD279X+hfc
	 N0tRDrKmccyBhqXRk4C8pLy+aXVI35nIiRfMpzCdAt8ONszKbKPVutdtEreSdDpq5H
	 MWxEaDwcaxFZ5N1INciFr2DDBI1Qb4kO8/VSDY/j9RXMxfnBpjuTdWT4rf+wYb190k
	 vkOJqcjaNty3wtaM/11y12av22xnAbDh/+/lrqnraWspOlhy1I0v+NUsSuLPm7b52O
	 A9RrIVcdDn1ZA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 6/6] perf mem: Add -T/--data-type option to report subcommand
Date: Wed, 31 Jul 2024 16:55:05 -0700
Message-ID: <20240731235505.710436-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240731235505.710436-1-namhyung@kernel.org>
References: <20240731235505.710436-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is just a shortcut to have 'type' in the sort key and use more
compact output format like below.

  $ perf mem report -T
  ...
  #
  # Overhead       Samples  Memory access                            Snoop         TLB access              Data Type
  # ........  ............  .......................................  ............  ......................  .........
  #
      14.84%            22  L1 hit                                   None          L1 or L2 hit            (unknown)
       7.68%             8  LFB/MAB hit                              None          L1 or L2 hit            (unknown)
       7.17%             3  RAM hit                                  Hit           L2 miss                 (unknown)
       6.29%            12  L1 hit                                   None          L1 or L2 hit            (stack operation)
       4.85%             5  RAM hit                                  Hit           L1 or L2 hit            (unknown)
       3.97%             5  LFB/MAB hit                              None          L1 or L2 hit            struct psi_group_cpu
       3.18%             3  LFB/MAB hit                              None          L1 or L2 hit            (stack operation)
       2.58%             3  L1 hit                                   None          L1 or L2 hit            unsigned int
       2.36%             2  L1 hit                                   None          L1 or L2 hit            struct
       2.31%             2  L1 hit                                   None          L1 or L2 hit            struct psi_group_cpu
  ...

Users also can use their own sort keys and -T option makes sure it has
the 'type' sort key at the end.

  $ perf mem report -T -s mem

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-mem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 24a4f0084f49..efa700d14c98 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -38,6 +38,7 @@ struct perf_mem {
 	bool			data_page_size;
 	bool			all_kernel;
 	bool			all_user;
+	bool			data_type;
 	int			operation;
 	const char		*cpu_list;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -317,6 +318,8 @@ static char *get_sort_order(struct perf_mem *mem)
 
 	if (mem->sort_key)
 		scnprintf(sort, sizeof(sort), "--sort=%s", mem->sort_key);
+	else if (mem->data_type)
+		strcpy(sort, "--sort=mem,snoop,tlb,type");
 	/*
 	 * there is no weight (cost) associated with stores, so don't print
 	 * the column
@@ -336,6 +339,10 @@ static char *get_sort_order(struct perf_mem *mem)
 	if (mem->data_page_size)
 		strcat(sort, ",data_page_size");
 
+	/* make sure it has 'type' sort key even -s option is used */
+	if (mem->data_type && !strstr(sort, "type"))
+		strcat(sort, ",type");
+
 	return strdup(sort);
 }
 
@@ -508,6 +515,8 @@ int cmd_mem(int argc, const char **argv)
 		   " between columns '.' is reserved."),
 	OPT_STRING('s', "sort", &mem.sort_key, "key[,key2...]",
 		   sort_order_help),
+	OPT_BOOLEAN('T', "type-profile", &mem.data_type,
+		    "Show data-type profile result"),
 	OPT_PARENT(mem_options)
 	};
 	const char *const mem_subcommands[] = { "record", "report", NULL };
-- 
2.46.0.rc1.232.g9752f9e123-goog

