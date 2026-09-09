Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272D05328CE;
	Wed,  9 Sep 2026 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952395; cv=none; b=nR6ANJqpAkqWgVB9igWlAWXwTkiaksiOgFoRune1f3i3Ahmw7qOLJPa2R/+EEylG3TbxdcpPBhjY9WU/aotHHjUaTLwGs6d8A8WD1u5rLlbNQDfdGutpei5Ez5XmiLT6SfUzSj8qJtgWzZv9mRJz3QBgf1ZAQL40BSfPvWZj7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952395; c=relaxed/simple;
	bh=vypM7GmJ5Phl86G7W1xD5IJBbIeGQQosbEwJ/ZjggjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owialX411Z6bpmeoNII6oXwtHPgyxAE7WC9PMxpqWC7a2AoQZYfHG+zqG+k1VYi+S9KILQ8sncz+BXVnSaf8rbGqDw22mtpwQrNo0BPefG1Ef9nqu9RI7kAl841jn/WxAQO85p0REvHrprhpIaxg7mrIBsDYBz+SzaJ3sr0pfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShPN8HII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShPN8HII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4B01F00A3E;
	Wed,  9 Sep 2026 11:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952387;
	bh=ngMscP67M93287oXTGrViIN/OWZ9/3SHVfrrJ06sBKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ShPN8HII79W94cOfU6EBM13SwZTDw5LJJLbKJuMs/Lb9uodDdougj3w3X9+iH5ESt
	 N/SISPp+CDZqK6fcMwEXbeWXlNRf+6IuLK+h0YNPOXwr66Ps0QCfMAfyJBJep8uU/e
	 m+wnZAObEbS9dUOmtVLoj009bXZ46yYFS3vzBHO+S2QdYTD7/AG/TuhxGmgYiFl8s4
	 3mr9ZOtRhl0Kd+VzjPb+P0uJdCXJ1rkgnBCnrgXVI5vJL+G3GQEDGDCcLWlONzlFle
	 IAMBNCwFdTVocBz0Hyfn724FbDY2uUN1qKU+n+Vj62I7u0VhYPeOYC9Aq+Nf03e2G6
	 pO+3rYLww0f+Q==
Date: Wed, 9 Sep 2026 08:13:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 0/3] perf tools: port UI from GTK2 to GTK4
Message-ID: <aqE_QOp-x1aOQsCX@x2>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>

On Tue, Sep 08, 2026 at 10:50:33PM -0400, Matt Turner wrote:
> GTK2 is long dead upstream and increasingly hard to keep building on
> current distros. This series ports perf's GTK-based report browser to
> GTK4 and fixes it up so it's actually loadable at runtime after the
> port.
> 
> Patch 1 does the mechanical port (build system, widget API changes),
> including the leftover-GTK2-call and signal-handling fixes that were a
> separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
> port that prevented the browser from loading. Patch 3 fixes two stack
> buffer overflows in the hierarchy view that predate the port.

I'm tentatively merging this, will test build on my distro container set
and perform some testing, thanks for working on this!

- Arnaldo
 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> Changes in v8:
> - Fix perf_gtk__add_hierarchy_entries() to restore hpp->buf/hpp->size
>   unconditionally after formatting each entry, not just before
>   recursing into children: leaf entries left the buffer state
>   advanced, so the next sibling in the traversal inherited a
>   shrunk hpp->size and an already-advanced hpp->buf, eventually
>   running hpp->size to 0 and pointing bf past the end of the
>   stack buffer for the strim(bf) call (reported in v7 review)
> - Link to v7: https://lore.kernel.org/r/20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com
> 
> Changes in v7:
> - Add patch 3: fix two stack buffer overflows in the hierarchy view
>   (perf_gtk__show_hierarchy()'s unbounded strcat() into a 512-byte
>   buffer, and an advance_hpp() size_t underflow in
>   perf_gtk__add_hierarchy_entries()). Both predate the GTK4 port
> - Link to v6: https://lore.kernel.org/r/20260906-perf-gtk2-v6-0-695d1c01aaa1@gmail.com
> 
> Changes in v6:
> - Explicitly include <string.h> in annotate.c (strcpy()) and
>   <stdarg.h>/<stdio.h> in hists.c (va_list, snprintf()) instead of
>   relying on transitive includes, which isn't guaranteed on musl
> - Link to v5: https://lore.kernel.org/r/20260906-perf-gtk2-v5-0-e8747a65c240@gmail.com
> 
> Changes in v5:
> - Fold v4's patch 3 into patch 1, since sigprocmask() only blocks
>   delivery to the calling thread: it did nothing to stop the signal
>   handler from running concurrently on another thread and doesn't make
>   the handler's GSList calls async-signal-safe either
> - Defer perf_gtk__exit() on SIGINT/SIGQUIT/SIGTERM to a GLib source via
>   g_unix_signal_add() instead of running it straight out of a real
>   signal handler, so it always runs on the main-loop thread, serialized
>   with perf_gtk__error()'s updates to perf_gtk__error_loops, instead of
>   racing them from arbitrary signal-handler context
> - Keep a real handler for SIGSEGV/SIGFPE, since those are synchronous
>   faults with no "later" to defer to, but pare it down to reporting and
>   reraising the default disposition: there's no safe way to run
>   GTK/GLib code from the faulting context itself
> - Link to v4: https://lore.kernel.org/r/20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com
> 
> Changes in v4:
> - Fix gtk_widget_show()/gtk_widget_hide() calls left over from the GTK2
>   port: both were removed in GTK 4. Replace with gtk_widget_set_visible(),
>   adding a small wrapper for the info-bar "response" signal callback
> - Block SIGSEGV/SIGFPE/SIGINT/SIGQUIT/SIGTERM around the
>   perf_gtk__error_loops list updates in perf_gtk__error(): the signal
>   handler (perf_gtk__signal() -> perf_gtk__exit() ->
>   perf_gtk__quit_error_dialog()) walks that same list and could fire
>   mid-update, corrupting it
> - Link to v3: https://lore.kernel.org/r/20260906-perf-gtk2-v3-0-e1f2086214a0@gmail.com
> 
> Changes in v3:
> - Fix GMainLoop leak if perf_gtk__error() is called re-entrantly: track
>   active loops in a list instead of a single global pointer
> - Add explicit <stdarg.h>/<stdio.h> includes instead of relying on
>   transitive inclusion, which musl doesn't guarantee
> - Drop the gtk4-infobar feature check and HAVE_GTK_INFO_BAR_SUPPORT:
>   GtkInfoBar has been unconditionally available since well before GTK 4,
>   and the check was failing outright due to its deprecation warning
> - Link to v2: https://lore.kernel.org/r/20260906-perf-gtk2-v2-0-3eccff053cd1@gmail.com
> 
> Changes in v2:
> - Fix error dialog's nested GMainLoop hanging if the parent window
>   closes or a signal arrives while the dialog is open (quit from
>   "destroy", not just "response")
> - Fix build with GTK_INFO_BAR_SUPPORT: gtk_info_bar_get_content_area()
>   is gone in GTK 4, use gtk_info_bar_add_child() instead
> - Fix use-after-free in the progress dialog on manual close
> - Fix reuse of an exhausted va_list in the vasprintf() failure path
> - Link to v1: https://lore.kernel.org/r/20260906-perf-gtk2-v1-0-7564bf8523a9@gmail.com
> 
> ---
> Matt Turner (3):
>       tools: port perf ui from GTK 2 to GTK 4
>       perf tools: make the GTK4 report browser actually loadable at runtime
>       perf tools gtk: fix two hierarchy-view stack buffer overflows
> 
>  tools/build/Makefile.feature                     |  4 +-
>  tools/build/feature/Makefile                     | 10 +--
>  tools/build/feature/test-gtk2-infobar.c          | 12 ---
>  tools/build/feature/{test-gtk2.c => test-gtk4.c} |  4 +-
>  tools/perf/Documentation/perf-report.txt         |  2 +-
>  tools/perf/Makefile                              |  2 +-
>  tools/perf/Makefile.config                       | 27 +++----
>  tools/perf/Makefile.perf                         |  6 +-
>  tools/perf/builtin-annotate.c                    |  8 +-
>  tools/perf/builtin-report.c                      |  8 +-
>  tools/perf/scripts/install-build-deps.sh         |  4 +-
>  tools/perf/tests/make                            |  4 +-
>  tools/perf/ui/gtk/annotate.c                     | 36 ++++-----
>  tools/perf/ui/gtk/browser.c                      | 96 ++++++++++++++++++-----
>  tools/perf/ui/gtk/gtk.h                          | 16 ++--
>  tools/perf/ui/gtk/hists.c                        | 72 +++++++++---------
>  tools/perf/ui/gtk/progress.c                     | 40 +++++++---
>  tools/perf/ui/gtk/setup.c                        |  5 +-
>  tools/perf/ui/gtk/util.c                         | 97 ++++++++++++++----------
>  tools/perf/ui/setup.c                            |  2 +-
>  tools/perf/util/annotate.c                       | 11 +++
>  tools/perf/util/annotate.h                       | 12 +--
>  22 files changed, 278 insertions(+), 200 deletions(-)
> ---
> base-commit: 9f0346dcbea363787186c94ef94dd01aaa215afa
> change-id: 20260906-perf-gtk2-555ca04bb652
> 
> Best regards,
> -- 
> Matt Turner <mattst88@gmail.com>
