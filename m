Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947372AEE1
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704326; cv=none; b=mSGALzgx0ErAyeea4pNoQYK961n1KZsoZ+SovOC8uYSWQH/UjccB7ABXRuM7tXKZLOwA8LL6v4SSX8nNePpbT67Du/1LUWjjYD3GDDl+WSMiV07WPE+fs5aeE+xvbfIRQ6kU/mXeu5NjN8yyr7T/JTB/WHYJADtcYwSKFLOIfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704326; c=relaxed/simple;
	bh=MtHeIXeNSJa658ItNv3mAUCc0rwr9F+hFl5vfimBdbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nAIUQC56rw3+hvP5JTgvtdKVGBUH5p18uQNKZ4tR12xJMuwQqt2gQMWI1ja7TeX3CKeL+gvIzLCP0biKxhOZdAYjt5hNwTXNfmKw1t0AzNNo8zF0M9ipzL2vJzBD8R6d4u0CxZlUeSRWpXblu1h4jglAnarvNvoIQFsc9EFuh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkRkKkIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkRkKkIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B11F00893;
	Sat,  6 Jun 2026 00:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780704325;
	bh=RVrQXoxDW+Va9h4PalXuoRjcc1aNOO73pPlJu6RRHRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QkRkKkIuW38R+ZEi7DwSwaSpP4cKZn5A/b7qiFCz5Xmb9/3u6NO2OBMghJu6YdDq1
	 sqUp7tZ4rwj2fy2hJuDIdLJ9+iPKCXeSGjyWAHuVHDmLi2mx0vdMqaC7byuxmxf+Td
	 C0LRnG7FrCyxVw6lOJttilponkgK/CLk+m/zAk4r+4EgvLz1K4sm4oFaTlnkkekkIR
	 IfZh/sNKz/0VtBFBr1gUhVV9Hqy3zQ1TKSYVdiT6HOAn5SqXNBAb5oE6W4OdH2Re7a
	 zwHfMFIidfQq139r5EUzHveVRaP4sNS2BsCCF/mUDTBS6ZVic5tjVz+wi/+YxGdqYd
	 aGW5xcK4d+66g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf timechart: Release event samples at the end
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605235131.2440270-2-namhyung@kernel.org>
References: <20260605235131.2440270-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:05:24 +0000
Message-Id: <20260606000525.1C7B11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The newly added timechart__release() function introduces a double-=
free vulnerability by unconditionally freeing cs->backtrace for all CPU sam=
ples, even though sched_switch() shares the exact same backtrace string poi=
nter between multiple samples.

Pre-existing issues:
- [High] Use-after-free inside cat_backtrace() error path due to freeing th=
e memstream buffer before closing the stream.
--

commit ee81a934b42b228370b97d5f0e7e208b04ba839a
Author: Namhyung Kim <namhyung@kernel.org>

perf timechart: Release event samples at the end
   =20
Add timechart__release() to free all data structures added during the
sample processing.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 28f33e39895d3..99f5102239963 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
[ ... ]
> @@ -1509,6 +1509,73 @@ static void write_svg_file(struct timechart *tchar=
t, const char *filename)
>  	svg_close();
>  }
> =20
> +static void timechart__release(struct timechart *tchart)
> +{
> +	struct per_pid *p =3D tchart->all_data;
[ ... ]
> +		while (c) {
> +			struct per_pidcomm *next_comm =3D c->next;
> +			struct cpu_sample *cs =3D c->samples;
> +			struct io_sample *ios =3D c->io_samples;
> +
> +			while (cs) {
> +				struct cpu_sample *next =3D cs->next;
> +
> +				zfree(&cs->backtrace);

[Severity: High]
Does unconditionally freeing cs->backtrace cause a double-free?

Looking at sched_switch() in tools/perf/builtin-timechart.c, it passes the
same dynamically allocated backtrace string pointer to pid_put_sample() for
both prev_pid and next_pid:

tools/perf/builtin-timechart.c:sched_switch() {
    ...
    pid_put_sample(tchart, prev_pid, TYPE_RUNNING, cpu,
                   prev_p->current->state_since, timestamp,
                   backtrace);
    ...
    pid_put_sample(tchart, next_pid, p->current->state, cpu,
                   p->current->state_since, timestamp,
                   backtrace);
    ...
}

Then pid_put_sample() stores this raw pointer into sample->backtrace without
duplicating it:

tools/perf/builtin-timechart.c:pid_put_sample() {
    ...
    sample->backtrace =3D backtrace;
    ...
}

Because the pointer is shared among multiple CPU samples, freeing it
unconditionally for every sample here could result in a double-free memory
corruption.

> +				cs->next =3D NULL;
> +				free(cs);
> +
> +				cs =3D next;
> +			}
[ ... ]
> @@ -2037,6 +2104,7 @@ int cmd_timechart(int argc, const char **argv)
> =20
>  	ret =3D __cmd_timechart(&tchart, output_name);
>  out:
> +	timechart__release(&tchart);

[Severity: High]
This isn't a bug introduced by this patch, but looking at cat_backtrace() in
the same file, is there a use-after-free in its error path?

When the callchain context is invalid, it attempts to discard the buffer by
freeing p:

tools/perf/builtin-timechart.c:cat_backtrace() {
    ...
    zfree(&p);
    goto exit;
    ...

But the goto exit path closes the stream:

    exit:
        addr_location__exit(&al);
        fclose(f);

        return p;
}

Because fclose(f) operates on the open stream, it accesses its internal
buffer to append a null byte. If p was flushed and freed, wouldn't this
cause a use-after-free?

Additionally, fclose(f) overwrites p with the buffer address, which means
the function might return a freed pointer to the caller.

>  	zfree(&cpus_cstate_start_times);
>  	zfree(&cpus_cstate_state);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605235131.2440=
270-1-namhyung@kernel.org?part=3D1
