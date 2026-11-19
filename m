Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057944;
	b=HrM6fu1zcz61QMOMT8LsHuz9d7Oaet4jBL/8HjFJxREfcsW+uy7jr3zO20sqAPUou0Lg
	 CiY8c9cEriJLpB4ndgLTOEWmNQNoKQIssxtyB0nE6efPq8vhaD54KKccnihRQzpKr+nak
	 Kn35472wSTz/PoEBNCmP52k5SapfhGd+PSg3w41FwYDNciiY9GeeobhOTurXvf4GCPEkW
	 HLSuOr/TXsVlbbazJ5vmAk1bXK/po2YdMnVSI8KLpUk8nFQ3EGYk8YOWdd0NhcpC5Ng27
	 aiCPtTjrkyeGG12ImGZetCMEiAFmQhQro6/tqgcKiLIdbz6fh/HLxVRBW0S3PASpNgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057944;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BkJypv3B5OIWI65pwJGtLRapGiHkqXJl5pv6AoeGTbw=;
	b=AnkoxMJW4mPI+lRa78ZBnyzEuMoIYerJkduGJ2l6q2ybOGtiTimJRizSJ1ILtZTOGeh6
	 LF2YMwh5WLWilwXIz0QDW8q/HbzxIVLKGUz0Uvrl0iCw+CL0uSyiIzb+TWETnMp3YZlhU
	 3HTwlVG2q+zIzJUrL135br3uhm3OdTzH8+f6VJYP2cU+zWItqWLPRjBH00KeRvbAVdc7n
	 R1YyLlvytDGxMtDsroi7PYYZ3ZM/+5RjuFTYR1Dbwi22835aGx0gITCYp6WFWBYktt1gg
	 X21Miz5jDmH+qnUfvC/wcpbEnjbHH7E8JfVeTda+lwucH2BNUCeZ5eX9dybf207qopA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0ZPpJFH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B99606A31C;
	Thu, 19 Nov 2026 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0ZPpJFH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358871F000C5;
	Thu, 19 Nov 2026 03:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795057944;
	bh=BkJypv3B5OIWI65pwJGtLRapGiHkqXJl5pv6AoeGTbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z0ZPpJFH0ZB3TRY9Dop+cmQF5POUyeOxXOxRQcPthLc7n2uRhMVsdQqZoosRZH/T8
	 a8UWbdFzXPsFCo4dp267kv1vajKt9Y+PeyPgIcyNOpxL1nOGAOovhT8Kk0VbDUiiCv
	 02TOu+HHaHrc2LdqtUOUDzpRVIhyOFyXDedndqZyDC3Gg+LKwtPqASN1jtIdJo93Hj
	 5YmvgbyRcF5zDh7PazDO2UP3J4DbI1X7YcOvYZparDYbjj8trNYZY4srSA6m6RLJ/q
	 EHAkuoklky0SsAR/ugX958emJI3ihiuqbL7QQetYlu0Y+4l8vzk9Wm/bqSmIqny3Ew
	 j0Ifk+QJiRGIg==
Message-ID: <sashiko-outbox-222370@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Require kallsyms permission for the .function
 filter modifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "JunYoung Lee" <ljyoung04@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261119025941.87102-1-ljyoung04@gmail.com>
References: <20261119025941.87102-1-ljyoung04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 03:12:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] tracing: unstripped cover letter and scissors line in commit
  message
--

commit 8240d9570c52f6cf2edfd9796cbc32ecb0f181af
Author: JunYoung Lee <ljyoung04@gmail.com>

> tracing: Require kallsyms permission for the .function filter modifier
>
> Hi Steven, Masami,
>
> An unprivileged user can locate the kernel image (KASLR bypass) with
> PERF_EVENT_IOC_SET_FILTER at the default perf_event_paranoid=3D2.
> parse_pred() accepts "<field>.function =3D=3D <addr>" only if the address
> resolves in kallsyms, and the perf path has no permission check, so the
> ioctl result tells whether an address is kernel text. The details and
> the fix are in the patch below.
>
> Affected (reproduced as uid 65534, KASLR on), since e6745a4da964 (v6.3):
> - mainline 4405c18c95d2 (v7.4-rc3-230)
> - stable 6.12.118
>
> Example on mainline: a counting event on ftrace:print (field "ip") and
> 561 probes return image_start=3D0xffffffffa1000000 and
> image_end=3D0xffffffffaae30000. These equal _stext and _end in
> /proc/kallsyms as read by root; the same user sees zeros there. No
> tracefs and no capabilities are needed. Not affected:
> perf_event_paranoid > 2, or perf_event_open blocked.
>
> A C reproducer is available privately on request.
>
> Testing of the patch on mainline with KASAN: for an unprivileged user
> every .function form now fails with -EINVAL, and ordinary filters still
> work. Root keeps .function via perf and tracefs (it is refused under
> kptr_restrict=3D2, like kallsyms values). ftrace selftests test.d/filter
> pass 4/4. checkpatch --strict and W=3D1 are clean. A 6.12.y backport is
> available.
>
> A separate issue seen while testing: as root, a .function filter on the
> perf function event (ftrace:function) crashes the kernel with a NULL
> dereference in ftrace_function_set_filter_pred(), because pred->regex
> is not set on the .function path. It needs CAP_PERFMON. I can send
> details if useful.
>
> Found with AI-assisted code analysis. All results come from test runs.
>
> Thanks,
> JunYoung Lee
>
> -- >8 --
> "<field>.function =3D=3D <operand>" resolves the operand to a kernel symb=
ol
> range. parse_pred() accepts the predicate only if
> kallsyms_lookup_size_offset() succeeds, so the result of setting the
> filter tells whether an address lies inside the kernel image (or a
> module).
>
> perf_event_open() allows any user to open a tracepoint event for
> counting at the default perf_event_paranoid=3D2, and
> PERF_EVENT_IOC_SET_FILTER passes the string to the same parser without
> a permission check. An unprivileged user can therefore probe addresses
> one ioctl at a time and recover _stext and _end exactly (about 560
> ioctls on x86-64, under two seconds), while /proc/kallsyms shows that
> user zeros.
>
> Apply the rule that /proc/kallsyms uses, kallsyms_show_value() on the
> current credentials, before the operand is looked at, so both the
> numeric and the symbol name form are refused to callers who may not
> see kernel addresses. Root and CAP_SYSLOG keep the modifier under the
> default kptr_restrict. With kptr_restrict=3D2 it is refused to everyone,
> the same as kallsyms values are hidden from everyone.
>
> Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to =
function names")
> Cc: stable@vger.kernel.org
> Signed-off-by: JunYoung Lee <ljyoung04@gmail.com>

[Severity: Low]
This isn't a bug, but the commit message retains the email greeting, notes
for the maintainers, and the "-- >8 --" scissors line above the actual
changelog.  Transient commentary intended for maintainers belongs below the
"---" separator after the Signed-off-by trailer (or should be stripped with
"git am --scissors") so it does not end up in permanent git history.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119025941.8710=
2-1-ljyoung04@gmail.com?part=3D1
