Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B464BA9F8;
	Tue, 13 Oct 2026 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931968; cv=none; b=Ir9JeQ8k87PVKWd3kIN12eCdzsvG71FFiswpnStLU9mTqujxx8UUViqdpd6BbiIhMrQ8rSUK1Ez6VVDrFfiaRiuOtHCfquc5fPZp9mNSvD9R8glBoQ4wQjGhMOD4NQutcgspXxz5UjuldKMPxqaOYB1v7E0oFyBLo8dAd565y/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931968; c=relaxed/simple;
	bh=nrycf58xKxcPSqDNmrmZPcGS0KgUnwC4/mtMsLchUkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7vcsFgpyAJKeeD/2pWER/MDM+zcJP0x4SZf3nQGqGsubjysLT4Ey/iwCNXGjgJYF7fXEKt84RiDt//xGPzop1UxIvnmCqexZCjMSkUdF23RoTnBetlZTxr0hsDP+GCf981mT4kuxzKAh7b6B5PIsAU0DQWwf9vv4LIPdbNl450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QFmg7PA8; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QFmg7PA8"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j48k6685pz1XM4Tn;
	Tue, 13 Oct 2026 22:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1791931956; x=1794523957; bh=3THyFQbxyvsdHPNjPBnRChM9
	szmNJjWSHMrgN1l6UOo=; b=QFmg7PA8mr6Dno54BVc8Bwz49a7gnyndUNt3GGgS
	ht8SYKd39hoTkcpn3U/0EQ9BWZWpNJJXJglQLFHbfSYiAsmBUI2REdRB9Hh4h0sn
	F3Rjx/ZcesNRHLXhi4TF0CntjL0o8ecNnWDh3bNYMVpE7XKnBUeCVhJNgxoYve7J
	A5Lc12fqhhbEeojGqpUHSjfjXCunrnguVsAyFQnOLizKGamlMRDnTa/xzkdSxW2s
	l80/krDk8o6mpH8vhB7BxFdJIu6ud6467S9p+9/1/sV1ZQcA45FZ1jCtRxW/Lnvz
	Y42wVv+LGg2PtmKzPuJRqwexUmnmxDH5n0zr033gSML6Gg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RujyzYs6toPt; Tue, 13 Oct 2026 22:52:36 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j48jt6h3Qz1XM4Tl;
	Tue, 13 Oct 2026 22:52:34 +0000 (UTC)
Message-ID: <3f57ddf4-b1a7-4c91-8983-c8cd83d0f25c@acm.org>
Date: Tue, 13 Oct 2026 15:52:33 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] tools/perf: Adopt kernel
 compiler-context-analysis.h annotations
To: Ian Rogers <irogers@google.com>, acme@kernel.org, elver@google.com,
 namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org,
 justinstitt@google.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev,
 mingo@redhat.com, morbo@google.com, nathan@kernel.org,
 ndesaulniers@google.com, peterz@infradead.org
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261013222622.1822619-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 3:26 PM, Ian Rogers wrote:
> The perf tool previously added Clang thread-safety annotations in
> tools/perf/util/mutex.h (GUARDED_BY, LOCKABLE, EXCLUSIVE_LOCK_FUNCTION,
> UNLOCK_FUNCTION, etc.). Since then, the Linux kernel has adopted a
> unified set of static context analysis macros and attributes in
> include/linux/compiler-context-analysis.h (context_lock_struct,
> __guarded_by, __acquires, __releases, __must_hold, etc.).

New versions of a patch series should be posted as a new e-mail thread
instead of as a reply to an existing email thread. Additionally, posting
a new version of a patch series only four hours after the previous
version is way too soon.

The LLM that I asked to take a look at this patch series came up with
the feedback below. Please take a look at this feedback.

Thanks,

Bart.

--------------------------------------------------------------------------

Verdict: Needs Substantive Revision

While the overall goal and majority of the annotations are 
well-executed, several patches bundle distinct bug fixes with 
refactoring and annotation churn (violating the "one logical change per 
patch" rule).
Additionally, there are concurrency and lifetime subtleties in the newly 
introduced dsos__findnew_id() read-lock fast path and vdso.c, an 
unsynchronized benign data race in maps.c, and missing Fixes: 
attribution tags.

2. Critical & Concurrency Findings

A. Patch 07/10: Lock drop-and-reacquire race and unneeded 
re-invalidations in dsos__findnew_id()

In tools/perf/util/dsos.c:

struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const 
struct dso_id *id)
{
	struct dso *dso;
	down_read(&dsos->lock);
	dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/false);
	if (dso && !dso__needs_improve_id(dso, id)) {
		up_read(&dsos->lock);
		return dso;
	}
	up_read(&dsos->lock);
	down_write(&dsos->lock);
	if (dso)
		__dso__improve_id(dso, id);
	else
		dso = __dsos__findnew_id(dsos, name, id);
	up_write(&dsos->lock);
	return dso;
}
Issue: If dso is found under down_read but needs ID improvement 
(dso__needs_improve_id(dso, id) == true), up_read() releases the lock. 
Before down_write() is acquired, another thread may have acquired 
down_write() and already improved the DSO's ID with the identical or 
better info.
Consequence: When down_write() is acquired, __dso__improve_id(dso, id) 
is executed unconditionally without re-checking dso__needs_improve_id(). 
While updating fields is mostly idempotent, __dso__improve_id() sets 
dsos->sorted = false;, unnecessarily degrading subsequent read lookups 
to qsort().
Fix: Re-check dso__needs_improve_id(dso, id) under down_write(). If no 
improvement is needed, avoid calling __dso__improve_id().
B. Patch 07/10: Unnecessary lock churn and array sort invalidation in vdso.c

In tools/perf/util/vdso.c:

static struct dso *__machine__addnew_vdso(struct machine *machine, const 
char *short_name, const char *long_name)
{
	struct dso *dso;
	dso = dso__new(short_name);
	if (dso != NULL) {
		dsos__add(&machine->dsos, dso);
		dso__set_long_name(dso, long_name, false);
	}
Issue: Calling dsos__add() followed by dso__set_long_name() causes two 
separate down_write(&machine->dsos.lock) acquisitions in immediate 
succession. Worse, dsos__add() inserts the DSO into the array ordered by 
its current short_name. Immediately afterwards, dso__set_long_name() 
mutates the name and explicitly sets dsos->sorted = false; (lines 1528 
in dso.c).
Fix: Set the long name before adding the DSO to dsos (matching the 
pattern used in dsos__findnew_module_dso() in util/dsos.c):

	dso = dso__new(short_name);
	if (dso != NULL) {
		dso__set_long_name(dso, long_name, false);
		dsos__add(&machine->dsos, dso);
	}

This requires only a single write lock acquisition in dsos__add() and 
keeps dsos->sorted = true.

C. Patch 10/10: Unsynchronized concurrent write in maps__find_by_name()

In tools/perf/util/maps.c:

struct map *maps__find_by_name(struct maps *maps, const char *name)
{
...
	while (!done) {
		down_read(maps__lock(maps));
...
		/* Second search sorted array. */
		if (!done && maps__maps_by_name_sorted(maps)) {
			struct map **mapp =
				bsearch(name, maps__maps_by_name(maps), __maps__nr_maps(maps),
					sizeof(*mapp), map__strcmp_name);
			if (mapp) {
				result = map__get(*mapp);
				i = mapp - maps__maps_by_name(maps);
				RC_CHK_ACCESS(maps)->last_search_by_name_idx = i;
			}
			done = true;
		}
		up_read(maps__lock(maps));
Issue: last_search_by_name_idx is written while holding only 
down_read(maps__lock(maps)). Because multiple reader threads execute 
maps__find_by_name() concurrently, this is a concurrent write race 
(which is why last_search_by_name_idx could not be annotated with 
__guarded_by(&lock)).
Consequence: Under TSAN or strict memory models, unsynchronized 
conflicting writes cause data races.
Suggestion: Use WRITE_ONCE()/data_race() on the assignment, or annotate 
last_search_by_name_idx with a brief comment explaining that this is an 
intentional, benign unlocked cache update.

3. Patch Architecture & Organization Findings

Per Documentation/process/submitting-patches.rst ("Separate each logical 
change into a separate patch"):

Patch 07/10 mixes 4 distinct logical changes:

Bug fix: Fixing the unlocked __dsos__add() call in __machine__addnew_vdso().
Performance optimization: Adding the read-lock fast path in 
dsos__findnew_id().
Refactoring: Replacing _dso__data_open_lock and pthread_once with 
DEFINE_MUTEX(dso__data_open_lock).
Annotations: Adding static context analysis macros across dso.c, dso.h, 
dsos.c, dsos.h.
Recommendation: Split this patch into at least 3 patches:
Standalone bug fix for vdso.c with a Fixes: tag (see metadata below).
Standalone performance optimization for dsos__findnew_id().
DSO/DSOs lock annotations and mutex cleanup.

Patch 09/10 bundles three disparate subsystems plus a bug fix:

Combines perf config, intel-tpebs, and perf_env.
Includes a real bug fix: fixing an unlocked read of tpebs_reader_thread 
after releasing tpebs_mtx in tpebs_stop().
Recommendation: Split the intel-tpebs race fix into its own commit with 
a Fixes: tag. Split the remaining annotations into separate commits per 
subsystem (perf config, perf intel-tpebs, and perf env).


