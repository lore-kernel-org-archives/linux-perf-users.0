Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252802F549F
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904916; cv=none; b=OGhNtLL9QSCJ+SzN++2Axt0jeAbxrbJqne06tfWCKKu07eYMc+tnCaBcn2zRlE4w0eU6nCDaamXjz5kGXXlS1bWyK6VMwsrFKzfwGJ76v/z3N0kSbgmRT33c/ooUHxLcM9oXzJOKTdROVQlE+/A16dOuF+5+zVbmZhMeQx1UDqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904916; c=relaxed/simple;
	bh=omnAV/QkoDK/0nBud+f+zu6NBgZ7qB+owcztTvCd5u0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nlQnNnW9H3/C7C0DqOB0WPLAiQpNvB14u+TWSHDXTtoPuFPNWIoTIiIXSivC9oB+S5KoPY5+ybeHcEY+SNcvHu2pcdEMMvDw2cg1bQva3/Ex/lIDCpqoXaj2CpabmJLQHnQq77eBP1WhJeDs1oSQI1NfOdHhTI5r+0UV9hVLz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HimGM9Gh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HimGM9Gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C7E1F000E9;
	Fri, 24 Jul 2026 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784904914;
	bh=4Z9LkJbKElkxJk5q9zzcmY8ocTuiE/0vHD8D/gb3IxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HimGM9GhSKlSDdv8GMCupB3PxxR5etrWN+QWW8eR3k7C7Wfw+wxrSLPg36EflRleZ
	 wkWJ00wwtVnZOSmagzJidp/1Sc+MQOTIXJgf051t+PgAxE2418YL/Y/McqND9TXhwK
	 Ssvr3sHmCpmYlEZQhQtD9aI/td2KJtQKkU3UQMIi5cgd0yFujhiMqBOJUhmV+OyXfM
	 L56SDqO3FnTOFct6jTBF38kZenzSbbMJ3rJr9c7KlleC5BzbUmmgcKBv5wrZhpg+Pn
	 nhCUs7auyYsC+f6g56jSz/9EUGOjDbbytBA/qn6u61JUQCaFUocqvYZHDJbQxjYTq2
	 Feqe5XsPHVIAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] perf trace-event: Avoid double free in
 trace_event__cleanup()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260724141316.99507-4-tshah@linux.ibm.com>
References: <20260724141316.99507-1-tshah@linux.ibm.com>
 <20260724141316.99507-4-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:55:14 +0000
Message-Id: <20260724145514.90C7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling trace_event__init() repeatedly on the same struct trace_ev=
ent leaks the previously allocated tep_handle and plugins.
--

--- Patch [3]: [PATCH v3 3/5] perf trace-event: Avoid double free in trace_=
event__cleanup() ---
commit 1eb2775370e0095c8df022b4a83dcd46f4b90b94
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Avoid double free in trace_event__cleanup()

trace_event__cleanup() frees t->pevent but never clears the pointer. It can=
 be
called twice on the same trace_event: once from trace_report()'s error path,
and again from perf_session__delete() during session teardown, resulting in=
 a
double free / use-after-free.

> diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
> index 6a8c66c64b705..cf40e98d16177 100644
> --- a/tools/perf/util/trace-event.c
> +++ b/tools/perf/util/trace-event.c
> @@ -63,8 +63,12 @@ int trace_event__register_resolver(struct machine *mac=
hine,
> =20
>  void trace_event__cleanup(struct trace_event *t)
>  {
> +	if (!t->pevent)
> +		return;
> +

[Severity: High]
This isn't a bug introduced by this patch, but while we are making it safe
to call trace_event__cleanup() multiple times, should we also call it from
trace_event__init() to prevent memory leaks?

If a maliciously crafted perf.data file contains multiple
PERF_RECORD_HEADER_TRACING_DATA headers, trace_report() can be called
multiple times on the same session, invoking trace_event__init() repeatedly:

tools/perf/util/trace-event-read.c:trace_report() {
    ...
	if (trace_event__init(tevent)) {
    ...
}

This overwrites the previously allocated tep_handle and plugins without
freeing them, leaking the memory:

tools/perf/util/trace-event.c:trace_event__init() {
    ...
		t->plugin_list =3D tep_load_plugins(pevent);
		t->pevent  =3D pevent;
    ...
}

>  	tep_unload_plugins(t->plugin_list, t->pevent);
>  	tep_free(t->pevent);
> +	t->pevent =3D NULL;
>  }
> =20
>  /*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141316.9950=
7-1-tshah@linux.ibm.com?part=3D3
