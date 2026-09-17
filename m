Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D9D4E5336
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661389; cv=none; b=Gl9d9lezXai18R8BwPrJKwbbFyZY+l1V5kdDiHvoFHzrxtyRmfsqjvKttOE6gYQ2XR5zNcCzesqYBy23cUVzV475/lyw7+1TkEXRATYcUHR9Mx919uDWKvXLBbpiE8IFyrEoHyUU5VGIMliLrEu5fDByG9A+7ScDkDDpwJJYLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661389; c=relaxed/simple;
	bh=ox2VrhqyNny3N5lNSR5PSQl7FeBgvOFnSzi1TEm352M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PYzoZRRp2Hi5BsLf19ynBxC0YZdFBsEGIJ4rvnnsNjqRTT59QNC3jg3F8z7QSfhFkIXYd1rWTEyzzOeYRqX0XDp7B/lxL2dCDSNLtbamaK2PDgKy1HASr6EgCET1ZbjhzaQgnuyIIZht2fXLdC/nAsx6QRYG3U2o++XKGFz4GqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGd+OauC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGd+OauC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE121F000FF;
	Thu, 17 Sep 2026 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661388;
	bh=JBRFCBS+OePmzr2mkhUO7wquA6VIiP+FD6l52IlHj+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QGd+OauCi3OyU9fhsqhebYrSyfAbCZ2++bWUg6P+9trahLcSyy+YeGxXmdKphwA5Z
	 XeswmEczDqPS5TjrES8TrDqzaEqhSkMHAUGBYB7cUSScTwcWXvMngNkhciIJpuyNLW
	 tueqmhCRqsEdG0Rwyqfi5UtXvQa3SeuStbCfqOLSxkIYx9eo9QxEiuytuKkN9/zo3L
	 vOEzfeDMyKUDyKbjfC0ZtHsfK2ebT5JFwdSTWX/7iYz8be56IeNIPXwLVu4inG4oT1
	 d1gpJsNvbcTckGtIvv+hrdormDyk+F9irVrq+pSLIND9HzVyEdW6tUen4U0T//GFwy
	 auW8/iuQjGYBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/15] perf debuginfo: Show the debuginfod fetch
 progress and keys in the TUI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-6-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:09:47 +0000
Message-Id: <20260917160948.4BE121F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf tui: SLang data race and input corruption during concurrent d=
ebuginfod fetch
--

commit 8d18f5ec06006e4e275aaf1773a82812d40a2e7f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

    perf debuginfo: Show the debuginfod fetch progress and keys in the TUI
   =20
    The stdio only fetch UI left a TUI fetch in progress with nothing on
    screen, indistinguishable from a stuck perf, with no way out of it.
    Draw a window over the browser with the fetch progress, and drain the
    's'/'d' keys from the TUI input queue, through the new
    ui__key_pending()/ui__key_read()/ui__progress_window()/
    ui__progress_window_end() primitives declared in ui/util.h and
    implemented in ui/tui/util.c, with no-ops for builds without slang:
    slang stays behind the ui/ layer and callers stay free of #ifdefs.

> diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
> index e4d322ce0b54c..280865e980ef5 100644
> --- a/tools/perf/ui/tui/util.c
> +++ b/tools/perf/ui/tui/util.c
[ ... ]
> +void ui__progress_window(const char *title, const char *text,
> +			 u64 fetched, u64 total)
> +{
> +	static char lines[PROGRESS_WINDOW_MAX_LINES][256];
> +	char buf_cur[20], buf_tot[20], bytes[64];
> +	size_t len;
> +	int y, height, nr_lines, inner, i;
> +
> +	if (use_browser !=3D 1)
> +		return;
> +
> +	unit_number__scnprintf(buf_cur, sizeof(buf_cur), fetched);
> +	if (total) {
> +		unit_number__scnprintf(buf_tot, sizeof(buf_tot), total);
> +		scnprintf(bytes, sizeof(bytes), "  %s / %s fetched",
> +			  buf_cur, buf_tot);
> +	} else {
> +		scnprintf(bytes, sizeof(bytes),
> +			  "  %s fetched, size unknown", buf_cur);
> +	}
> +
> +	if (progress_window__shown && !strcmp(bytes, progress_window__bytes))
> +		return;
> +
> +	scnprintf(progress_window__bytes, sizeof(progress_window__bytes),
> +		  "%s", bytes);
> +	progress_window__shown =3D true;
> +
> +	ui__refresh_dimensions(false);
> +	mutex_lock(&ui__lock);
> +	/*
> +	 * SLsmg_write_nstring() takes the width as an unsigned int, so never
> +	 * let a narrow terminal make it negative.  Clamp it.
> +	 */
> +	inner =3D SLtt_Screen_Cols - 2;
> +	if (inner < 0)
> +		inner =3D 0;
> +	else if (inner > 255)
> +		inner =3D 255;
> +	nr_lines =3D progress_window__wrap(text, inner, lines);

[Severity: High]
Does this code introduce data races on the static buffers?

The ui__progress_window() function updates static variables like
progress_window__bytes, progress_window__shown, and the static lines array
before acquiring the ui__lock.

Since debuginfod fetch callbacks can execute on the process_thread while the
display_thread is running, can concurrent updates corrupt these buffers and
state flags?

[ ... ]
> +/*
> + * The keys typed while the fetch blocked the browser are in the TUI
> + * input queue: nobody else is reading it, drain them through these.
> + */
> +bool ui__key_pending(void)
> +{
> +	return use_browser =3D=3D 1 && SLang_input_pending(0) > 0;
> +}

[Severity: High]
Can calling this corrupt the terminal state when debuginfod fetches occur?

This calls SLang_input_pending() directly without synchronization. Since
ui__key_pending() can be triggered via debuginfod__tui_poll_cancel_keys()
from the process_thread during a background fetch, it can race with the
display_thread running ui__getch().

> +
> +int ui__key_read(void)
> +{
> +	return SLang_getkey();
> +}
> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 0ec11e1ad7508..737dd445d42bb 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
[ ... ]
> +/*
> + * The browser thread is the one doing the fetch, so its input queue has
> + * the keys typed while it was busy, drain those.
> + */
> +static void debuginfod__tui_poll_cancel_keys(void)
> +{
> +	while (ui__key_pending())
> +		debuginfod__cancel_key(ui__key_read());
> +}

[Severity: High]
Does this loop silently drop any keystrokes other than 's' or 'd'?

When debuginfod__cancel_key() processes input, it only handles 's' and 'd',
meaning any other keys read from the queue are discarded rather than being
passed back to the TUI.

When this runs on the process_thread, could it drop user input intended for
the display_thread?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D5
