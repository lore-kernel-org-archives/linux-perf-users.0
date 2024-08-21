Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7017965E;
	Wed, 21 Aug 2024 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282790; cv=none; b=dFFEBeOcBLc0yyCKIY6kliq9BgdokK0OMEV8Fj14lcH51WK0C+87VQuxNVaEtzH27dAm/OnpIVuEm12zbijYdJ34xa9VfqzHrnoM7rFnPvR4HTrbAEXQN/R3tH6StiMoYttM4jjzYXusPhIjx4OjR+w9NNjXQ7PIoVPa74d7yp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282790; c=relaxed/simple;
	bh=V9uUFtnCEofy9pZNCgLGWmzdiSL6s971iB5YFrDqJro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kj7t/sAEoeSHerFc1R4K5agdNMZwQ5e8M78/h11d7csNuM/js0Hi18WwynzL+lEC320tudhT4h5/PewZP7g5BGU2SERdRO8ooiSFP2NIJanvLOb8MWcZHO6DcHtGKqBLJVIvssJ2WfVor5JoIBFrlBEFhPDt8rwBZOI/8w782SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAIGhEDS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAIGhEDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35CAC32782;
	Wed, 21 Aug 2024 23:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724282790;
	bh=V9uUFtnCEofy9pZNCgLGWmzdiSL6s971iB5YFrDqJro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAIGhEDSkHbQhszZZczJGE7kVJkDSDTw2EzjSwWolGg2qfZaafyDgoxQO5HmQ5W7W
	 C35Cox9UhnmpRY5X2St6LvdZCE1I0s62Q52m9QPVWsDlsP89b3P01p5AvfMfLSh4d+
	 y/QeuPrEn/Mog45AYAeNamBb0xteo2cdIHPkil4Vz0/7CeNkwNoA3DypOJ3vIX4UlT
	 ByAyO3S/38SMsAVzc/3w3zZKcITN/nsjqf7YELPn/ZmAgFydENb5PzvjvI1IdDWOdF
	 aH5PzFsan18rvb/WC5MO2zPCJAW5pgOYqSsTl/KQRrq1Dgem1pWxga7Cxkg3Y3xed8
	 s/zpkc3KXY0aA==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/4] perf dwarf-aux: Handle bitfield members from pointer access
Date: Wed, 21 Aug 2024 16:26:25 -0700
Message-ID: <20240821232628.353177-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240821232628.353177-1-namhyung@kernel.org>
References: <20240821232628.353177-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __die_find_member_offset_cb() missed to handle bitfield members
which don't have DW_AT_data_member_location.  Like in adding member
types in __add_member_cb() it should fallback to check the bit offset
when it resolves the member type for an offset.

Fixes: 437683a994189 ("perf dwarf-aux: Handle type transfer for memory access")
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 0151a8d14350..92eb9c8dc3e5 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1977,8 +1977,15 @@ static int __die_find_member_offset_cb(Dwarf_Die *die_mem, void *arg)
 		return DIE_FIND_CB_SIBLING;
 
 	/* Unions might not have location */
-	if (die_get_data_member_location(die_mem, &loc) < 0)
-		loc = 0;
+	if (die_get_data_member_location(die_mem, &loc) < 0) {
+		Dwarf_Attribute attr;
+
+		if (dwarf_attr_integrate(die_mem, DW_AT_data_bit_offset, &attr) &&
+		    dwarf_formudata(&attr, &loc) == 0)
+			loc /= 8;
+		else
+			loc = 0;
+	}
 
 	if (offset == loc)
 		return DIE_FIND_CB_END;
-- 
2.46.0.184.g6999bdac58-goog

