Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAAE78C63;
	Sun,  2 Jun 2024 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717363099; cv=none; b=gLgy23mjfhjl+96W51KfwsYMNvhrbFOp7VXhIkIxrv5RjAUjKJZs2piRIxXII2Twu5YIpmC6xZJ57T0c4g4BIuj2FNC625x4TnKGpHcl6QjLDx+4HFlS1xoSZWYq23AEJy8m7uQi1xt2/gIcYymnpTeG/japLcuYEkb9MuWeF/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717363099; c=relaxed/simple;
	bh=QzFjFrj/mP8nA0Xy/3KnACpqTWrVeIQK/K/u2FIamR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pomme+BvBQnexyn/whAGOgbtqkNuCGNjw0ieCOZMSqm2z+jzS1eirCsejyeNrxq+da4Uv27PAIkioOkfm+k3e97DT9bFsDu3Kc90CwN65msd6z///uIem4WPceQQzHoyBefhprVdrJ4R4mgTJXkoWIxUwiXozr50vGJgSZvoJU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuEnnXBD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuEnnXBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5C7C2BBFC;
	Sun,  2 Jun 2024 21:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717363098;
	bh=QzFjFrj/mP8nA0Xy/3KnACpqTWrVeIQK/K/u2FIamR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuEnnXBDvdlQEP/iAOwWRs5XH9FvRojMazoeYGEZaketSSfWJYY9dQuA0dzHkih5V
	 3Svhq1L9rp0B+Kf0L3hEhLF8iX/TM2R2nLRCwhjGR7sWgHfeyliduCrk/IgyIu5qY4
	 fDJwyOkUUw9E0Xlj3/JgiRSCsutiMzmEF50q5NCZPvx6ZSCxJit294ykccM8BnEIXJ
	 fQ1kX9cq7Mq/tyZBUKoumwQKvxm8pjdjIE29T3Cni83egiIZ3y6yauaNdJopc7KKLc
	 zwtjdTD9qv2+4flQJwhrFZyQgNqwgqCai3/j3FazAEQLxYu5CllXO3brRJ8pZLrpuR
	 8CxQ3IGfmVnDQ==
Date: Sun, 2 Jun 2024 14:18:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v10 0/8] TPEBS counting mode support
Message-ID: <ZlzhmBcM9OP0SRfT@google.com>
References: <20240529064327.4080674-1-weilin.wang@intel.com>
 <CAM9d7cj676sty01zqJVyk9DVesVYNFgVTZ329X=UP3xgV2aDfA@mail.gmail.com>
 <CO6PR11MB5635D7581425EF0F089EA781EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7chSC=n2sCc_nhgwqHYnBhSjMhH1quAY6_JWXNhrk1ri8Q@mail.gmail.com>
 <CO6PR11MB563586B37B444C5B45408B80EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CO6PR11MB563586B37B444C5B45408B80EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>

On Fri, May 31, 2024 at 11:03:25PM +0000, Wang, Weilin wrote:
> 
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > As I said, please don't open event1:R (for perf stat) and let tpebs_stop() set
> > the value using the data from perf record in background.
> 
> I think this is exactly what I'm trying to achieve, not open event1:R for perf stat. 
> The problem is that I'm not sure how to do it properly in the code. Please give 
> me some suggestion here. 

Ok, I think the problem is in the read code.  It requires the number of
entries and the data size to match with what it calculates from the
member events.  It should not count TPEBS events as we don't want to
open them.

Something like below might work (on top of your series).  Probably
libperf should be aware of this..

Thanks,
Namhyung

---8<---

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ac7a98ff6b19..7913db4a99e0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1559,6 +1559,60 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 	perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
 }
 
+static bool evsel__group_has_tpebs(struct evsel *leader)
+{
+	struct evsel *evsel;
+
+	for_each_group_evsel(evsel, leader) {
+		if (evsel__is_retire_lat(evsel))
+			return true;
+	}
+	return false;
+}
+
+static u64 evsel__group_read_nr_members(struct evsel *leader)
+{
+	u64 nr = leader->core.nr_members;
+	struct evsel *evsel;
+
+	for_each_group_evsel(evsel, leader) {
+		if (evsel__is_retire_lat(evsel))
+			nr--;
+	}
+	return nr;
+}
+
+static u64 evsel__group_read_size(struct evsel *leader)
+{
+	u64 read_format = leader->core.attr.read_format;
+	int entry = sizeof(u64); /* value */
+	int size = 0;
+	int nr = 1;
+
+	if (!evsel__group_has_tpebs(leader))
+		return perf_evsel__read_size(&leader->core);
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		size += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		size += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_ID)
+		entry += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_LOST)
+		entry += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_GROUP) {
+		nr = evsel__group_read_nr_members(leader);
+		size += sizeof(u64);
+	}
+
+	size += entry * nr;
+	return size;
+}
+
 static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int thread, u64 *data)
 {
 	u64 read_format = leader->core.attr.read_format;
@@ -1567,7 +1621,7 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
 
 	nr = *data++;
 
-	if (nr != (u64) leader->core.nr_members)
+	if (nr != evsel__group_read_nr_members(leader))
 		return -EINVAL;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -1597,7 +1651,7 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 {
 	struct perf_stat_evsel *ps = leader->stats;
 	u64 read_format = leader->core.attr.read_format;
-	int size = perf_evsel__read_size(&leader->core);
+	int size = evsel__group_read_size(leader);
 	u64 *data = ps->group_data;
 
 	if (!(read_format & PERF_FORMAT_ID))
@@ -2210,8 +2264,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 	if (evsel__is_retire_lat(evsel)) {
 		err = tpebs_start(evsel->evlist, cpus);
-		if (err)
-			return err;
+		return err;
 	}
 
 	err = __evsel__prepare_open(evsel, cpus, threads);
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index d099fc8080e1..a3857e88af96 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -354,10 +354,11 @@ int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
 	 */
 	if (cpu_map_idx == 0 && thread == 0) {
 	/* Lost precision when casting from double to __u64. Any improvement? */
-		val = t->val;
+		val = t->val * 1000;
 	} else
 		val = 0;
 
+	evsel->scale = 1e-3;
 	count->val = val;
 	return 0;
 }
