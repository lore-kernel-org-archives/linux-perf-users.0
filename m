Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546909;
	b=g3bRETslUzJgzGdcx8WibUpgL/NJWw1W8pFe5mH/saVWwPnfJb2V724C93rCpHr3LVpi
	 qxREJHR3SdWUtI+aT9zQZCYak4l6OmGAj/XAJUDgC1YBNMBkoWsYbPinsZCTOTOLab4Ce
	 qpYn2jqk+SNGDqN27gUPM6PG6B6/CvARs3RXuhbbgQBaqi2Hyf/pS9t0xumoNdAbUqB8f
	 MUGY7YzqrMSuWaCyBry9tzvszXErcjz1PJ3s8EH5ElNvU6jIiQgY/ahERNzDA0LeaNkQQ
	 +J99ajgqecxJxiVCdDO3FqCeZdhgUVxubxqsypFxphnSQ5OX9Vg92ydue5VWULMkFng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546909;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y/a9ItqmubS3RO/qKP0yfnHl+km4FQ6U2mr1xTgpVws=;
	b=Ci0L975yzdHTLUKm2ODSd7rv43639OysR6lLWyFHbG28DozTLLFlmPdC5eJUsQgMLNhI
	 1i7WfV3OjGihV5EDMNq121vU00R42WMpWDhguj9WHo2Sl6AzvtPolGNQioiP8ixBWbQ4u
	 BEI1aU1+O95Nl82J8eMZ9ujlDfIED6Z++4MxhVK1/YDbqe9gMksutv0KbqWlFRxB7q3/z
	 57BBrRy8qS8apGk4YNkkTjsUDp8MqSL13Jio3cL4w3FyFNjNTYq66bni8WL/GyHmrM4ig
	 pxxzEIzVnT9FMWPY0/PtRHGRbNfwdFx+jsEiwC+YPCjUvgw84lBvo9qVbMdSGWjL0eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boZWqct2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8AA606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boZWqct2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A6C1F000C4;
	Tue, 24 Nov 2026 19:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546908;
	bh=Y/a9ItqmubS3RO/qKP0yfnHl+km4FQ6U2mr1xTgpVws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=boZWqct26+7dLklUwXwfJbpuIgGNSZXM+vc7XL0yo4x1HtUrKEt1mUQXX9a6G+UTR
	 a9TiHztk4gaaPiltwWf5w6Ci77Nq/DeaEULf9MJFnM2MAjSAsdB/Omg5WpttcJ7WNC
	 fApFu6D48lEv5RFKD39W0Gfoo/XDrKydyRSEqrUE6qhufrQtLlgdNSiq97h3GRCf3s
	 lBTTskjFK06Jsq5XJeNnGZs+PFhMl7TsTq4QN8yFXNJtO7V6zYGP3mxDcsZfkiAqyB
	 kzjeYZplUV9lwIeK6EVzjtDJqMbEEd9wYIwU1505/leb/hkzJ4uAhQS6Jawhn3bFi4
	 T9CKlPdBjKceg==
Message-ID: <sashiko-outbox-231871@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 17/17] perf tests report: Exercise the TUI browsers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-18-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
 <20261124184604.24983-18-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:01:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf tests report_tui: multi-event menu and kptr_restrict
  modal dialog hang
- [Medium] perf tests report_tui: debuginfo and os.write() EIO failure
  in annotate test
--

commit a2002eeed86b16048de69b871224382c3a77c477
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests report: Exercise the TUI browsers

This commit adds a shell test that runs perf report and perf annotate in
TUI mode inside a Python pty harness and verifies that the expected browser
screens are rendered in response to key presses.

> diff --git a/tools/perf/tests/shell/report_tui.sh b/tools/perf/tests/shel=
l/report_tui.sh
> new file mode 100755
> index 0000000000000..bf5ff1c4c3f6f
> --- /dev/null
> +++ b/tools/perf/tests/shell/report_tui.sh
> @@ -0,0 +1,112 @@

[ ... ]

> +with open(outfile, "wb") as out:
> +	while True:
> +		now =3D time.time()
> +		if now > deadline:
> +			os.kill(pid, 9)
> +			sys.exit(2)
> +		if keys and now >=3D next_key:
> +			os.write(fd, keys[:1])
> +			keys =3D keys[1:]
> +			next_key =3D now + 0.7
> +		r, _, _ =3D select.select([fd], [], [], 0.1)
> +		if r:
> +			try:
> +				chunk =3D os.read(fd, 65536)
> +			except OSError:
> +				break

[ ... ]

> +echo "TUI record"
> +if ! perf record -q -o "${perfdata}" -- perf test -w noploop 1; then
> +	echo "TUI record [Failed: perf record failed]"
> +	cleanup
> +	exit 1
> +fi
> +
> +run_tui "report" "q" "Overhead" perf report --tui -i "${perfdata}"
> +run_tui "report help" "?qq" "Help" perf report --tui -i "${perfdata}"
> +run_tui "report dso zoom" "dq" "Overhead" perf report --tui -i "${perfda=
ta}"
> +run_tui "report thread zoom" "tq" "Overhead" perf report --tui -i "${per=
fdata}"

[Severity: Medium]
Can running perf record without a single user-space event and perf report
without -q cause these tests to fail or hang until the 20-second timeout?

When no event is specified, evlist__new_default() creates one cycles event
per core PMU.  On hybrid systems with multiple core PMUs, perf.data holds
multiple events, so evlist__tui_browse_hists() enters the event-selection
menu in perf_evsel_menu__run() instead of opening the histogram browser.
In that menu, pressing q exits before Overhead is ever drawn, while
pressing d or t opens an unhandled-hotkey modal dialog that consumes the q
key and leaves perf report blocked until the deadline kills it.  Similarly,
__cmd_annotate() iterates over each evsel with samples, so a single q only
closes the first PMU's browser.

In addition, default recording captures kernel samples when
perf_event_paranoid <=3D 1.  If kallsyms addresses are restricted by
kptr_restrict, report__warn_kptr_restrict() calls ui__warning() on startup,
opening a modal warning dialog that consumes the first key sent by
tui_keys.py.

Passing -e cpu-clock:u (or -e cycles:u) to perf record and -q to perf
report --tui would ensure a single user-space event and suppress startup
warning dialogs.

> +run_tui "annotate" "q" "Percent" perf annotate --tui -i "${perfdata}"
> +# noploop is built without debug info, so 's' opens the "no source code"
> +# warning and the first 'q' only dismisses it; the second one quits.
> +run_tui "annotate source" "sqq" "Percent" perf annotate --tui -i "${perf=
data}"

[Severity: Medium]
Can the annotate source test fail with an unhandled OSError in tui_keys.py
when perf is built with debug info?

tools/perf/tests/workloads/Build compiles noploop.o with the default
CORE_CFLAGS, which includes -g in debug builds (such as DEBUG=3D1 or
EXTRA_CFLAGS=3D-g).  When DWARF info is present, pressing s in
annotate_browser__toggle_source() finds annotation__has_source(notes) true
and toggles the source view without opening a warning dialog.  The first q
in sqq then exits perf annotate immediately, and when tui_keys.py sends the
second q via os.write(fd, keys[:1]) (which, unlike os.read(), is not
wrapped in try/except OSError), writing to the closed pty raises EIO and
fails the test.

Conversely, if a user's ~/.perfconfig sets annotate.hide_src_code =3D false
and debug info is absent, __hist_entry__tui_annotate() opens the "Annotation
has no source code." modal warning on startup, consuming the single q in
the first annotate test and causing it to hang until the timeout.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org?part=3D17
