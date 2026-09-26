Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A1547057
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430381; cv=pass; b=FT/IwAoNzf0guHFX+qUA0oXYjzZnau85CqeYgTbVpqlXc4kVPh/Gc45r9d/feCXI4+D4PPWqqi+X67oQX0R7n4g5ndQWgdGYD93rjohJNH8BNB/uQDXu+ay/VjNvHuXMbgC82Md24RzCKWPAJQLlo1UR/LVz2O3fIKXQlX76LBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430381; c=relaxed/simple;
	bh=Tx1oOOC0NfZU6KNipWxxzy84I8pBGTmceJk/A55dXM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFT1wWkWkIxyk/P+KZNani3B/ZtO1W9lW+/SATX/4BBMdBZsK2ULm3SwbssG/DDUZEmDbLow38PZ4WWwzhcxUIaEx9yhiHyR6gKFdwDOg67OrtAXcGLZmkQC2PlivoQdx26TElm9GzYSr4Ol4YRTKT0eAtsKIGML6kKYCaG31cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1lXNwJo; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1lXNwJo"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-530e8c6fb80so128731cf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790430379; cv=none;
        d=google.com; s=arc-20260327;
        b=OXtPJIKIzUV/z0I5JvMEgvKPSAsg5Eb1+xw0OKd9fq4Xuds3bDFe9YNPyoPFwRZq3Z
         rN+2WYIrsbIUKXLpfrazvWfETp4NiVd3yyxTL3X7psqjEiXQmQK+MJ5p7E5/fiIdlEQa
         OzLBQXlsrEqn2YFfDH3iDotL45XT1F3YCdItUppNSLwmtJFucnEB4SHWfRnYRcZ81s8A
         TWy0BoLvjLglv27NrLjJSYEhcbMfNK/6HouJR0DVzQRUIVO8MnHLytjiagyMACdanPKe
         MfV+4pLfJztZDAP9Gc9tcvg3jE/jq6tzf5jS73UWQ5nZrkogrLMf3pc551SCGLo24jWO
         zwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vJLu3kDSRfbZXFyhHWOsWhCoWdaigpzzohCPc4GKQh4=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=me2D3ZlQlXNmE1u55Jw51L9WWcSU/S2FFSn5+5Ur+gSiIrHBkHAnPZmsWY7lif8qAB
         QlrxoDQl+ATx5m/GyLOn78MCQqUQkJ4GVeK6jUlfxcw55yU2W10UMVKjRzevpcBYaqOL
         OX437HO/3qk8RbjeLEBNp7KhbtZBaZDvEeBWpuIp8SJqWvwY8LbChfVLfS82dAZsm7m5
         2MfNH7pCPfmWMWAaT0Sk/hIAtfaMIWVUusXuaNZ/iUnOPm2DQ3cSxMsjOrFhVjJFDUkQ
         uOnVzuSJLd/6G9nF085X12YfIOVFb4bXld8PPJWqFaMyTWxm1rEwQsfCFslG2/Q3ZQmL
         NteQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790430379; x=1791035179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vJLu3kDSRfbZXFyhHWOsWhCoWdaigpzzohCPc4GKQh4=;
        b=S1lXNwJo8g+PGqE5XC7iLVRw4fP373YCrzp6EAhxKec7Mf772tnfMPaWmPtPWDdEfm
         9b6jIy29xZXfNkQTvL62uyNaosLltTHoXUtLJ62psLdQImb/rolyCcsavvlS5ub/W+Vt
         ewH3TJ4nziagC/CLMOuzyHtSi+FB+SMZcEf1xbzRZgdiTCPNCitgbLw3BkKbyL15kB9x
         kOa8P4crZaTTOG6RrmR4qVdRFre7Vtzcig6evf+ADNb8S17cfVmdveP5wy5paxs2Ceda
         3+jw1Jl0X4wzqpQCDmdK2fKFddj2uRgrYpVn7zPlByrzJF5NbZbJy5YIkuUfWxzsdlC4
         e+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790430379; x=1791035179;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vJLu3kDSRfbZXFyhHWOsWhCoWdaigpzzohCPc4GKQh4=;
        b=UCwtrNEnpFKKgBfSuzcPqNnoWmhu9ITRgzYBOt6moOSy3YkcCFk7eFYa/LrQzgTlYY
         TiM0WsLXGaxgrTpK6wCJ0iKvNmFLfcLwNCqOG2eLAeA4x+d5ihgC9u9TCu3tJTAy5lQn
         qfEkbp1grw+Tn23u40B/wO4enYQhOEBoB9W9TXHxkCIRbw0KryovUm13FXPyIwx6BWyd
         +cyWJGKapzlwu94cNobRMT6hG7kqznM/12tS6Jb1/Zul7sOOGKt4inM1WEdxNV3EHymW
         k+99WHCTD9+omYJ085Z2XKngnNwX7yHQgXX5LuNhaHJf3oo+Rlz0ZcbT6FRftLUTAJW1
         6l2Q==
X-Gm-Message-State: AFuF++l+Rgm+K/upZMOt2iWkr8PAQaTSZDzxihVxvhTI5ITRw2jQpIH7
	XXCEgxlOq0Rrq8K5cFBsPdFUGewhCJCo9XaaXj+OSq+/x/xux0eXZ0ofxeWpchTai2EfzAmEqoK
	QdzSJedOobeHJ+oPbKiLQN6cpsas4sHwvJeq8U0NRffiR0QN5oCMc2IJEWTg=
X-Gm-Gg: AYBFou1XIECiZzyS0x3S0i8fgd4JvawAeR6dzBcyhxrhB+e3yShyRrBSN19s0v4smmg
	DzktzJIDlUdTgn6L3aCQkFNe/QmetOxx3Hny4zLdEDykZfDCtQSNuivTZ6phXZUBAejxkK8jXuN
	0ZmDRwwyx/uIs5kIUOE3ARF4sP8SClnROI8mg4rrPnJRSI1amFxnUcR3HRoAUbExG5jExgs2W2Q
	Pss7xpxEDIlHQUmVEcNbqiDCRqSQH3fT7gHFRl2GT4dZo1OxGRyaqg0hETYgrcv9n/BBZL61iC0
	3suOmtawVkY917EsEgmJ+5Wm+emr5k9mK8OyJ88ywzu2IHan/eWDOXY=
X-Received: by 2002:a05:622a:598c:b0:532:858d:e791 with SMTP id
 d75a77b69052e-533201552e2mr13447991cf.8.1790430378320; Sat, 26 Sep 2026
 06:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-22-irogers@google.com> <20260926063435.5FDD21F000FF@smtp.kernel.org>
In-Reply-To: <20260926063435.5FDD21F000FF@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 26 Sep 2026 06:46:06 -0700
X-Gm-Features: AclHuK8XMz-BOrz2CX67qrrrD064GgmoSWiLrW7QQhmG6NSRGgZn1LOhVzl2UbU
Message-ID: <CAP-5=fURGSJtYcs0jP+oyRZOX6w5KNRF73V-KswmzQN9DTUAPA@mail.gmail.com>
Subject: Re: [PATCH v4 21/49] perf python: Port event_analyzing_sample to perf module
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:34=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] perf python: SQLite journal symlink attack via shared temp direc=
tory
> --
>
> commit 69d795499ff20d3b762362308ad4405d0fa32d19
> Author: Ian Rogers <irogers@google.com>
>
> perf python: Port event_analyzing_sample to perf module
>
> This commit ports the event_analyzing_sample.py script to a standalone sc=
ript
> using the perf module and standard library sqlite3. It adds database
> encapsulation and argparse options, while removing Python 2 compatibility
> and adding type annotations.
>
> > diff --git a/tools/perf/python/event_analyzing_sample.py b/tools/perf/p=
ython/event_analyzing_sample.py
> > new file mode 100755
> > index 0000000000000..15b47cff9fa30
> > --- /dev/null
> > +++ b/tools/perf/python/event_analyzing_sample.py
>
> [ ... ]
>
> > +def trace_begin(db_path: str | None =3D None) -> None:
> > +    """Initialize database tables."""
> > +    print("In trace_begin:\n")
> > +    if not db_path:
> > +        fd, db_path =3D tempfile.mkstemp(prefix=3D"perf_events_", suff=
ix=3D".db")
> > +        os.close(fd)
> > +        _DB.temp_path =3D db_path
> > +    con =3D sqlite3.connect(db_path)
>
> [Severity: High]
> Can this sequence open a race window for symlink attacks via SQLite journ=
al
> files?
>
> When tempfile.mkstemp() creates the main database file in the shared /tmp
> directory, it doesn't reserve paths for SQLite's auxiliary sidecar files
> like -journal or -wal.
>
> If a local attacker monitors /tmp and observes the newly created base fil=
ename,
> could they immediately create a symlink for the -journal file pointing to=
 an
> arbitrary target before sqlite3.connect() writes to it?
>
> If a privileged user runs the script without specifying a database path,
> would SQLite follow the symlink and clobber the target file when writing
> to the journal?
>
> Would it be better to use tempfile.mkdtemp() to create a secure private
> directory for the database (similar to export-to-sqlite.py)?

The legacy script hardcoded `sqlite3.connect("/tmp/perf.db")`, so
`tempfile.mkstemp()` was used here to avoid a fixed `/tmp/perf.db`
path when `--db` is not specified. Note that on Linux
`fs.protected_symlinks=3D1` and SQLite's `O_NOFOLLOW` when opening
journal/WAL files already prevent `/tmp` symlink clobbering, and when
`--db` is omitted the temporary database is unlinked in `trace_end()`.

Switching the default (no `--db`) path to use `tempfile.mkdtemp()` (or
`sqlite3.connect(":memory:")`) is a nice cleanup. If there is a v5
I'll add that fix to the series; otherwise, I'll send a small
follow-up patch once this series lands.

Thanks,
Ian

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.80=
0743-1-irogers@google.com?part=3D21
