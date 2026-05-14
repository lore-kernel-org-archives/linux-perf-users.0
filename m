Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813001A7264
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718845; cv=none; b=pnF4WNfKyzP5CeuR4G5JgxdyaP36pwZLrAQ89wGSxnskmeaLjqoYOY/nFGQUdUETbAqiVfvru4rKwcbtJIoe/RKTajy2VXNJVuUIFyNpaya6p+eybqtspIuXudI07b0Za25bYXUzebUIJ4RS/pSwP4LIYpqEk9woNe2pXt2XeAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718845; c=relaxed/simple;
	bh=dXzJafzVP9uKkHm1IU6TJ2uxJKZ2z8/QXQdlFp5OuTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G0thkH6F0owDvb2hRXww9la5pEs1pdpVobpbCXfhQCU8r3tu/j2gN0Q3/51LcVxNobe12qEn3xzW0Lu/8DERCR+nrJWfxZUKgekJd58B1ArvSwvk6lRpcfss1sWGWuFRGgkPepgxOi3Z4e1nLJO4itQeGZuKsQZMC6TzJgvqpaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqat43fq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqat43fq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2428FC19425;
	Thu, 14 May 2026 00:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778718845;
	bh=dXzJafzVP9uKkHm1IU6TJ2uxJKZ2z8/QXQdlFp5OuTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Nqat43fqb+GO5DoSinjKPuR0KzeoWu74yXkxV3VdTkR1rpeBt5j0DA614alDFWc7L
	 GPUeVpdqoNTqifaZFPSkUTFSieFd5xsDOZZn/lxPxeICz5Cwe1KvpPHV0D+R3WrJsR
	 FwpOmd63FsSkjZ0H0pBaLkKDjED7w/y+1wbANN+C6mMQduv8341HaT54xH6eD0WDX1
	 zfDKpPJ3Znb0nymUHMg3RUYFOGgMe3CR/ffMkmljt4Iz8K8WAnEWDB0Fk/ujYZKx/b
	 xGkflFntF1A47m9MiOpNrG6/kf7mmMeHfubheOqBAmbyfrJkGcyDMYEj8OVJ+hMgns
	 LRkNpiPH7nctw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf data convert ctf: Initial babeltrace2 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512215621.468685-2-irogers@google.com>
References: <20260512215621.468685-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:34:04 +0000
Message-Id: <20260514003405.2428FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Dead code in `ctf_writer__init` masks initialization errors and ca=
uses a NULL pointer dereference.
- [High] Broken `CLEANUP` macro in `ctf_writer__cleanup_data` leaks Babeltr=
ace data types and causes double-frees.
- [High] Queue state corruption in `queue_push` silently drops all queued m=
essages if flushing fails.
- [High] Infinite loop (hang) occurs in `ctf_writer__flush_streams` if the =
Babeltrace2 graph fails.
- [Medium] Missing feature test source file makes Babeltrace 2 support impo=
ssible to enable.
- [Medium] Unchecked allocation and memory leak of the message queue array =
`c.queue`.
- [Medium] Redundant double-cleanup in `bt_convert__perf2ctf` when Babeltra=
ce 2 is disabled.
--

commit 2a217a42e8def55aac066b30e548c1ca1f15911c
Author: Ian Rogers <irogers@google.com>

perf data convert ctf: Initial babeltrace2 support

This commit adds experimental support for libbabeltrace2 to the perf data
CTF conversion tool. It introduces a message iterator, graph, and component
classes to replace the deprecated libbabeltrace 1 stream writer APIs.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 333ddd0e4bd81..3e3c4f240ee8f 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
[ ... ]
> @@ -1067,7 +1069,16 @@ ifndef NO_LIBBABELTRACE
>      EXTLIBS +=3D -lbabeltrace-ctf
>      $(call detected,CONFIG_LIBBABELTRACE)
>    else
> -    $(warning No libbabeltrace found, disables 'perf data' CTF format su=
pport, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev)
> +    $(call feature_check,libbabeltrace2)

Is there a missing feature test source file for libbabeltrace2?
The build system's feature_check relies on compiling a matching test file in
tools/build/feature/test-libbabeltrace2.c. Because this test file is
missing, the compilation test will permanently fail, preventing
HAVE_LIBBABELTRACE2_SUPPORT from being enabled.

[ ... ]
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-con=
vert-bt.c
> index 3b8f2df823a9b..b16544f8b9b9a 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
[ ... ]
> +static void queue_push(struct convert *c, bt_message *msg)
> +{
> +	unsigned int next_head =3D (c->queue_head + 1) & c->queue_mask;
> +
> +	while (next_head =3D=3D c->queue_tail) {
> +		/* Queue is full, drive the graph to consume */
> +		if (ctf_writer__flush_queue(c) < 0)
> +			break;
> +		next_head =3D (c->queue_head + 1) & c->queue_mask;
> +	}
> +
> +	c->queue[c->queue_head] =3D msg;
> +	c->queue_head =3D next_head;

Does this code corrupt the queue state if flushing fails?
If ctf_writer__flush_queue() returns < 0, the loop breaks and assigns
next_head to c->queue_head. Since next_head still equals c->queue_tail,
the head and tail pointers become identical. This effectively marks the
ring buffer as empty, silently dropping all queued messages.

[ ... ]
>  static void ctf_writer__cleanup_data(struct ctf_writer *cw)
>  {
> -	unsigned int i;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(cw->data.array); i++)
> -		bt_ctf_field_type_put(cw->data.array[i]);
> +#ifdef HAVE_LIBBABELTRACE2_SUPPORT
> +#define CLEANUP(type)					\
> +	if (cw->data.type) {				\
> +		bt_field_class_put_ref(cw->data.s64);	\
> +		cw->data.s64 =3D NULL;			\
> +	}

Could this macro cause memory leaks and double-frees?
It hardcodes cw->data.s64 instead of operating on the provided type
parameter. When expanded for subsequent types (e.g., u64, s32), it checks
their presence but exclusively frees and nullifies s64, leaving the other
field classes leaked and potentially double-freeing s64.

[ ... ]
>  static int ctf_writer__init(struct ctf_writer *cw, const char *path,
> -			    struct perf_session *session, bool tod)
> +			    struct perf_session *session __maybe_unused,
> +			    bool tod __maybe_unused, struct convert *c __maybe_unused)
>  {
> +#ifdef HAVE_LIBBABELTRACE2_SUPPORT
[ ... ]
> +	err =3D setup_streams(cw, session);
> +err:
> +	if (sink_comp_class)
> +		bt_component_class_sink_put_ref(sink_comp_class);
> +	if (src_comp_class)
> +		bt_component_class_source_put_ref(src_comp_class);
> +	if (iter_class)
> +		bt_message_iterator_class_put_ref(iter_class);
> +	return 0;
> +
> +	ctf_writer__cleanup(cw);
> +	if (err)
> +		pr_err("Failed to setup CTF writer.\n");
> +	return err;

Does the unconditional return 0 here mask initialization errors?
It leaves the actual error reporting and cleanup logic unreachable.
If graph creation or component initialization fails, the function will fals=
ely
report success, which could lead to a NULL pointer dereference later when
bt_graph_run_once() is called on the uninitialized graph.

[ ... ]
> -static int ctf_writer__flush_streams(struct ctf_writer *cw)
> +static int ctf_writer__flush_streams(struct convert *c)
>  {
[ ... ]
> +#ifdef HAVE_LIBBABELTRACE2_SUPPORT
> +	while (c->queue_head !=3D c->queue_tail)
> +		ctf_writer__flush_queue(c);

Could this result in an infinite loop?
If ctf_writer__flush_queue() encounters an error and returns -1, it does
not advance the queue pointers. Since the return value is ignored, the loop
will spin indefinitely without consuming any messages.

[ ... ]
>  int bt_convert__perf2ctf(const char *input, const char *path,
>  			 struct perf_data_convert_opts *opts)
>  {
[ ... ]
> -	struct convert c =3D {};
> -	struct ctf_writer *cw =3D &c.writer;
> -	int err;
> +	struct convert c =3D {0};
> +	int err =3D -1;
> +
> +	dump_trace =3D 1;
> +	debug_data_convert =3D 3;
> +	/* Setup queue */
> +	c.queue_size =3D QUEUE_SIZE;
> +#ifdef HAVE_LIBBABELTRACE2_SUPPORT
> +	c.queue =3D zalloc(sizeof(bt_message *) * c.queue_size);
> +	c.queue_mask =3D c.queue_size - 1;
> +#endif

Is there a missing allocation check and free for c.queue?
The dynamically allocated c.queue is never checked for failure, which would
cause a NULL pointer dereference in queue_push() under memory pressure.
Additionally, there appears to be no corresponding free() in the cleanup
path, leading to a memory leak.

[ ... ]
>  	cleanup_events(session);
>  	perf_session__delete(session);
> -	ctf_writer__cleanup(cw);
> -
> -	return err;
> -
> -free_writer:
> -	ctf_writer__cleanup(cw);
> -free_session:
> -	if (c.ptime_range)
> -		zfree(&c.ptime_range);
> -
> -	perf_session__delete(session);
> -	pr_err("Error during conversion setup.\n");
> +	ctf_writer__cleanup(&c.writer);
> +#ifndef HAVE_LIBBABELTRACE2_SUPPORT
> +	ctf_writer__cleanup(&c.writer);
> +#endif
>  	return err;
>  }

Is the double-cleanup intentional when Babeltrace 2 is disabled?
ctf_writer__cleanup() is called unconditionally, and then a second time ins=
ide
the #ifndef block. While the first call zeroes the structure, feeding a
zeroed state back into the cleanup function might be unsafe for older
libbabeltrace1 APIs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512215621.4686=
85-1-irogers@google.com?part=3D2
