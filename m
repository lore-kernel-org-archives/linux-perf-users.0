Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166123382DB
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253039; cv=pass; b=JBzWaSHvakLpbTEo8IqsxgfafLAZ6d9VQJvrX4XMJ3WXEzP2C/rbY9pK+EgqrCeH3xnfuGo1bRUnvddvIpI13cFlvhmlV5P7/0XiHLD26Mx5n+IN1jwvxy5cJej77vI5WLaie2tbCFL7a6rPcjGjId8xsYf/6eVR6mmlf8rnPqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253039; c=relaxed/simple;
	bh=vSLKPyRTrxihpOkqEeFIAcoAoPoVguCqjUV0mIRTPmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4jaKHoxDqTgqpUTlL4azSKrZkQHje31kfJp5OctI+iJq8qooMZEtmBSTrvoRNi6G+cif61oKmK2PjWOVMV/nMC7kP9cUEPQSDt1p6lqGJUJDlsLV7m3EcFCQdrOqF4osRmZ6GjHXAnpNm0W/lxDf720Uq+e4liBtpAQY/OGM2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UR6i9pn/; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UR6i9pn/"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-11a247de834so1854c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 13:23:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768253036; cv=none;
        d=google.com; s=arc-20240605;
        b=jvcjjJSiKyYgNAluoKA2ldDhqEU4qZRKYQPlXjh5/K0yP7zDjce0KhuCGskxO42hyC
         0OlIPyEuDqj8XJIwsKqhHWvJ5pIrV7FZvdAT1hfZeayJdL3EdR239z0tCPA3lvPxK2jf
         mCLjBqmlN8fY7sZm46ZDeWiFmwK50QRCULfiuoApurElyRYf+tgiU2CfYbjaSvyPMCN7
         1zw276Yfp7alyre4DfKgxOSZtnBqWcZdSlURN0tCh7AjUwQWLHfsDAoP96OD5QIVZm82
         oPvYCAn1sQLCZq+RrKwolC/1V4Y7NIhHg4ID36tsArF1nSwwF9ecNz2qLlXhUZ0etGX6
         HB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lqnswVgcAN2xYnATPjZykGiYXLflZ1TErMsxU8FYtXY=;
        fh=B0oCgSlrxK8gEbY1X2LePZN116eIh3Td04ktMRbPG6o=;
        b=bJltiMR+FLBLascmvvWNJBLnQ18cSiZ/sS3h0urV3xnsuiargT+llEuNySgIUk0zBB
         4ajmcZsIYpy+gtxEcIBMFnPHyawkva1cIJifjaCN1aBfc2vOBoUQrngDWtUDufASRgo2
         ftSBdmcRN6cpq1xsazrMcNbJsi5tzcT+idA68O1ARu6506nIqbYvgGawftIv6ZbDMvw9
         mUcL/3FUa7ppYfN2HI26RbAf/R0zzuRrlPc5owsz6fJYVnTHMswVd0cHkboYZn8mZFr2
         FDtUcM4OOf6V4h82jaUkNOlbPv26fKfhr+TDOTgVQtAFGfYHEywQoGm/QM0KJFMdwhiC
         +wsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768253036; x=1768857836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqnswVgcAN2xYnATPjZykGiYXLflZ1TErMsxU8FYtXY=;
        b=UR6i9pn/kaRknN/qAwcPUI/DdZPSfLgkL+zQvmE6kXyLDQnU1NhF0XcDxIsMtS5ANT
         chdJWVmeIuRUf7MnuW4ySEVTv4chWxx7UtNwHMUfmNyGOSRNzTYQRABMMGrBZZ3/HOSc
         jAHuloYpGvu50oTxoEJOUIFq9EGbrs+MODP81xnGXDp5U5Z1Bp0uktAY7vRTZHneDsf1
         EO35FjZMGp2QOKYG6MYwcK7Z6/GKDJI34MwmaJFwnOMQkNT1LmFEv7AEJ2/R9jfHy3R3
         fND0JlqhOx87qT2D+AODrbijTfd+qCbU8ysby9eM7KxPXk/MFB7SS17EOF/C2yzZca0Y
         ymBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768253036; x=1768857836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lqnswVgcAN2xYnATPjZykGiYXLflZ1TErMsxU8FYtXY=;
        b=IIkOyOKbC7QIn7nixhktrk3bOq5vkqlbgIWI3H2jUDObSb8ahTMm+/QY6KnQAkti8e
         QkNTA7+s28R7MkRVLZiRwocsRNfgbWzH4dn/Ow36QXhqJs2P/0vH71C0CEYqfhf490Et
         hEH9aQhMcIXzFWlSIblJyRPFVrAwtFmRMgXm2rZgIsCGe67w7X91SHNLzS2Gv7wLm1zZ
         ECKkxNL40N6rUHlfUvP9vzAqcBEdxz6lDcI4YP/h7xQG7+qKSayBh4ZIfbbO/byghL+G
         zqQKJrRm3KRjKqrol2cBqUe9dJkXsj9Ye3yCcd6RQkiEBMT4u78FgbhC9LueevEt/IGL
         4clQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUNYK/Y5JB1vBruvAWKkOZZU+6ZB81zJ1zZfi2CfKwrLuev6XGMA9UPJNcx5izUKSo8geGpO5UUxtEuh5WbYez@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2SetewrIUMEL3FccEEmiOQSM14mrF9bBYOraXosPFMsWcXL/
	X/D1JrOd2cG71NjyBWQ/Fou0bvUdMyUZvjUHMYi3hItY2LfulxdgsLzR81RZn+qE7O0h5AwlEj2
	OR4Wu1Qem/rvEZYhJKmlQLxf9dnr7QnHuvscJ3fWo
X-Gm-Gg: AY/fxX44B3vrbapAvLNOV2DOPf+BEheMPHDwTLDTl8cYqSaMh0sQR2WpvaMvAg43tUY
	mISLUGz1sk1U8AMEaKxUmmYeGVcCejlzqMqU4CxcxzfQT5ZDLAHwKxsBXbt5Xn/mQhqdjeR4jTx
	+XFRBlRVOyWVPpDryX5X8DJNhGKQbnsIo3sLPGgXh5havnpJtGH/63y97UbzjzVVhBNi4DdSOIc
	MjZpjCtytsfFWwgWh5XEcmcbAkzEzeAj0hQnDC90dpgnad3IGuBU/VaIwD2mnG/iV6HEGmRgBIz
	mHmvAQu8TBRpdbXDL8DUI7iC6sE1SBc+76bB
X-Received: by 2002:a05:7022:e801:b0:11f:38dd:8927 with SMTP id
 a92af1059eb24-1232ca547f7mr2353c88.5.1768253035651; Mon, 12 Jan 2026 13:23:55
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111041338.1817056-1-irogers@google.com> <20260111041338.1817056-3-irogers@google.com>
 <aWVQ63NemEu5mNZo@x1>
In-Reply-To: <aWVQ63NemEu5mNZo@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Jan 2026 13:23:43 -0800
X-Gm-Features: AZwV_Qho2Ldu-NvQ0FwRygri5gjtVKTroZVQmaMGk6vkyCAl5zYjtow3ioXYtH0
Message-ID: <CAP-5=fV2++t93_=Ar2+r+i3U3kpt1pUwWOT-fmyOV8F8z9GckQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] perf addr2line: Add a libdw implementation
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 11:52=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sat, Jan 10, 2026 at 08:13:33PM -0800, Ian Rogers wrote:
> > Add an implementation of addr2line that uses libdw. Other addr2line
> > implementations are slow, particularly in the case of forking
> > addr2line. Add an implementation that caches the libdw information in
> > the dso and uses it to find the file and line number
> > information. Inline information is supported but because
> > cu_walk_functions_at visits the leaf function last add a
> > inline_list__append_tail to reverse the lists order.
>
> So while testing I moved the inlineloop 'perf test' workload to the
> front to test without this new libdw implementation and then with it,
> and tested using perf probe on it:
>
> root@number:/home/acme# perf probe -x ~/bin/perf libdw__addr2line%return =
'ret=3D$retval'
> Added new event:
>   probe_perf:libdw_addr2line__return (on libdw__addr2line%return in /home=
/acme/bin/perf with ret=3D$retval)
>
> You can now use it in all perf tools, such as:
>
>         perf record -e probe_perf:libdw_addr2line__return -aR sleep 1
>
> root@number:/home/acme# perf trace -e probe_perf:libdw_addr2line__return =
perf report -f --dso perf --stdio -s srcfile,srcline
>      0.000 :1204769/1204769 probe_perf:libdw_addr2line__return(__probe_fu=
nc: 7698362, __probe_ret_ip: 7030548, ret: 1)
>      0.007 :1204769/1204769 probe_perf:libdw_addr2line__return(__probe_fu=
nc: 7698362, __probe_ret_ip: 7030548)
>      0.680 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.685 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.689 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.692 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.696 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.699 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.702 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.705 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.709 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.712 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.715 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.718 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.721 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.724 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.727 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.729 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.732 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.734 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.737 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.740 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>      0.771 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     13.563 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     13.766 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>     14.099 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548)
>     14.103 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.105 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.134 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.143 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.242 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.244 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.245 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.246 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.248 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.250 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.251 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.252 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.258 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.260 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.265 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.267 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.268 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
>     14.270 perf/1204769 probe_perf:libdw_addr2line__return(__probe_func: =
7698362, __probe_ret_ip: 7030548, ret: 1)
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 4K of event 'cpu/cycles/Pu'
> # Event count (approx.): 5535180842
> #
> # Overhead  Source File   Source:Line
> # ........  ............  ...............
> #
>     99.04%  inlineloop.c  inlineloop.c:21
>      0.46%  inlineloop.c  inlineloop.c:20
>
>
> #
> # (Tip: Save output of perf stat using: perf stat record <target workload=
>)
> #
> root@number:/home/acme#
>
> Putting more probes to see the fallbacks...
>
> root@number:/home/acme# perf probe -l
>   probe_perf:cmd_addr2line (on cmd__addr2line@util/addr2line.c in /home/a=
cme/bin/perf)
>   probe_perf:libbfd_addr2line (on libbfd__addr2line@util/libbfd.h in /hom=
e/acme/bin/perf)
>   probe_perf:libdw_addr2line (on libdw__addr2line@util/libdw.c in /home/a=
cme/bin/perf)
>   probe_perf:llvm_addr2line (on llvm__addr2line@util/llvm.c in /home/acme=
/bin/perf)
>   probe_perf:libdw_addr2line__return (on libdw__addr2line%return@util/lib=
dw.c in /home/acme/bin/perf with ret)
> root@number:/home/acme#
>
> As we have:
>
> static int addr2line(const char *dso_name, u64 addr, char **file, unsigne=
d int *line_nr,
>                      struct dso *dso, bool unwind_inlines, struct inline_=
node *node,
>                      struct symbol *sym)
> {
>         int ret;
>
>         ret =3D libdw__addr2line(dso_name, addr, file, line_nr, dso, unwi=
nd_inlines, node, sym);
>         if (ret > 0)
>                 return ret;
>
>         ret =3D llvm__addr2line(dso_name, addr, file, line_nr, dso, unwin=
d_inlines, node, sym);
>         if (ret > 0)
>                 return ret;
>
>         ret =3D libbfd__addr2line(dso_name, addr, file, line_nr, dso, unw=
ind_inlines, node, sym);
>         if (ret > 0)
>                 return ret;
>
>         return cmd__addr2line(dso_name, addr, file, line_nr, dso, unwind_=
inlines, node, sym);
> }
>
> root@number:/home/acme# perf stat -e probe_perf:*_addr2line perf report -=
f --dso perf --stdio -s srcfile,srcline
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 4K of event 'cpu/cycles/Pu'
> # Event count (approx.): 5535180842
> #
> # Overhead  Source File   Source:Line
> # ........  ............  ...............
> #
>     99.04%  inlineloop.c  inlineloop.c:21
>      0.46%  inlineloop.c  inlineloop.c:20
>
>
> #
> # (Tip: To set sampling period of individual events use perf record -e cp=
u/cpu-cycles,period=3D100001/,cpu/branches,period=3D10001/ ...)
> #
>
>  Performance counter stats for 'perf report -f --dso perf --stdio -s srcf=
ile,srcline':
>
>                 44      probe_perf:libdw_addr2line
>                 23      probe_perf:llvm_addr2line
>                  0      probe_perf:libbfd_addr2line
>                  0      probe_perf:cmd_addr2line
>
>        0.036554827 seconds time elapsed
>
>        0.030570000 seconds user
>        0.006049000 seconds sys
>
>
> root@number:/home/acme#
>
> Maybe asking for the dso_name may help understand why it is falling back
> 23 times to the llvm based one...
>
> root@number:/home/acme# perf probe -x ~/bin/perf llvm__addr2line dso_name=
:string
> Target program is compiled without optimization. Skipping prologue.
> Probe on address 0x5f73e4 to force probing at the function entry.
>
> Added new event:
>   probe_perf:llvm_addr2line (on llvm__addr2line in /home/acme/bin/perf wi=
th dso_name:string)
>
> You can now use it in all perf tools, such as:
>
>         perf record -e probe_perf:llvm_addr2line -aR sleep 1
>
> root@number:/home/acme# perf trace --libtrace -e probe_perf:llvm_addr2lin=
e perf report -f --dso perf --stdio -s srcfile,srcline
>      0.000 perf/1205478 probe_perf:llvm_addr2line((5f7416) dso_name_strin=
g=3D"/root/.debug/.build-id/cc/315df11334de01fb444465f08f6bca45a12bd2/elf")
>      0.697 perf/1205478 probe_perf:llvm_addr2line((5f7416) dso_name_strin=
g=3D"/root/.debug/.build-id/cc/315df11334de01fb444465f08f6bca45a12bd2/elf")
>      0.704 perf/1205478 probe_perf:llvm_addr2line((5f7416) dso_name_strin=
g=3D"/root/.debug/.build-id/cc/315df11334de01fb444465f08f6bca45a12bd2/elf")
>      0.708 perf/1205478 probe_perf:llvm_addr2line((5f7416) dso_name_strin=
g=3D"/root/.debug/.build-id/cc/315df11334de01fb444465f08f6bca45a12bd2/elf")
>      0.712 perf/1205478 probe_perf:llvm_addr2line((5f7416) dso_name_strin=
g=3D"/root/.debug/.build-id/cc/315df11334de01fb444465f08f6bca45a12bd2/elf")
> <SNIP>
>
> root@number:/home/acme# readelf -wi /root/.debug/.build-id/cc/315df11334d=
e01fb444465f08f6bca45a12bd2/elf | head -30
> Contents of the .debug_info section:
>
>   Compilation Unit @ offset 0:
>    Length:        0x20 (32-bit)
>    Version:       5
>    Unit Type:     DW_UT_partial (3)
>    Abbrev Offset: 0xad87
>    Pointer Size:  8
>  <0><c>: Abbrev Number: 38 (DW_TAG_partial_unit)
>     <d>   DW_AT_stmt_list   : 0
>     <11>   DW_AT_comp_dir    : (indirect line string, offset: 0xc9c): /us=
r/src/debug/glibc-2.42-5.fc43.x86_64/elf
>  <1><15>: Abbrev Number: 57 (DW_TAG_base_type)
>     <16>   DW_AT_byte_size   : 8
>     <17>   DW_AT_encoding    : 7        (unsigned)
>     <18>   DW_AT_name        : (indirect string, offset: 0x9bf1): long un=
signed int
>  <1><1c>: Abbrev Number: 57 (DW_TAG_base_type)
>     <1d>   DW_AT_byte_size   : 1
>     <1e>   DW_AT_encoding    : 6        (signed char)
>     <1f>   DW_AT_name        : (indirect string, offset: 0x7bab): char
>  <1><23>: Abbrev Number: 0
>   Compilation Unit @ offset 0x24:
>    Length:        0x20 (32-bit)
>    Version:       5
>    Unit Type:     DW_UT_partial (3)
>    Abbrev Offset: 0xad87
>    Pointer Size:  8
>  <0><30>: Abbrev Number: 38 (DW_TAG_partial_unit)
>     <31>   DW_AT_stmt_list   : 0
>     <35>   DW_AT_comp_dir    : (indirect line string, offset: 0xc9c): /us=
r/src/debug/glibc-2.42-5.fc43.x86_64/elf
>  <1><39>: Abbrev Number: 57 (DW_TAG_base_type)
> root@number:/home/acme#
>
> Some partial unit glibc DWARF 5. I think we need some more libdw setup
> to handle those?

Could be. Thanks for the analysis!

> But then we can merge what James already reviewed and go on from here,
> right?

+Masami Hiramatsu

I believe so. I'm not aware of anything outstanding on the patches -
v2 was using the function's declaration file:line rather than its
calling file:line, but that's all resolved in v3 and I'm not aware of
anything else left outstanding. Perhaps James can comment more on the
(non-blocking) issues he faced with LLVM and perhaps Masami can
comment on the libdw usage (I just checked that he did a lot of the
dwarf-aux.c work).

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/Build     |   1 +
> >  tools/perf/util/dso.c     |   2 +
> >  tools/perf/util/dso.h     |  11 +++
> >  tools/perf/util/libdw.c   | 153 ++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/libdw.h   |  60 +++++++++++++++
> >  tools/perf/util/srcline.c |  24 ++++++
> >  tools/perf/util/srcline.h |   1 +
> >  7 files changed, 252 insertions(+)
> >  create mode 100644 tools/perf/util/libdw.c
> >  create mode 100644 tools/perf/util/libdw.h
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 1c2a43e1dc68..2bed6274e248 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -224,6 +224,7 @@ perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-powerpc.o
> >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-x86.o
> >  perf-util-$(CONFIG_LIBDW) +=3D debuginfo.o
> >  perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
> > +perf-util-$(CONFIG_LIBDW) +=3D libdw.o
> >
> >  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind-local.o
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 344e689567ee..06980844c014 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -32,6 +32,7 @@
> >  #include "string2.h"
> >  #include "vdso.h"
> >  #include "annotate-data.h"
> > +#include "libdw.h"
> >
> >  static const char * const debuglink_paths[] =3D {
> >       "%.0s%s",
> > @@ -1605,6 +1606,7 @@ void dso__delete(struct dso *dso)
> >       auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
> >       dso_cache__free(dso);
> >       dso__free_a2l(dso);
> > +     dso__free_a2l_libdw(dso);
> >       dso__free_symsrc_filename(dso);
> >       nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
> >       mutex_destroy(dso__lock(dso));
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index f8ccb9816b89..4aee23775054 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -268,6 +268,7 @@ DECLARE_RC_STRUCT(dso) {
> >       const char       *short_name;
> >       const char       *long_name;
> >       void             *a2l;
> > +     void             *a2l_libdw;
> >       char             *symsrc_filename;
> >  #if defined(__powerpc__)
> >       void            *dwfl;                  /* DWARF debug info */
> > @@ -334,6 +335,16 @@ static inline void dso__set_a2l(struct dso *dso, v=
oid *val)
> >       RC_CHK_ACCESS(dso)->a2l =3D val;
> >  }
> >
> > +static inline void *dso__a2l_libdw(const struct dso *dso)
> > +{
> > +     return RC_CHK_ACCESS(dso)->a2l_libdw;
> > +}
> > +
> > +static inline void dso__set_a2l_libdw(struct dso *dso, void *val)
> > +{
> > +     RC_CHK_ACCESS(dso)->a2l_libdw =3D val;
> > +}
> > +
> >  static inline unsigned int dso__a2l_fails(const struct dso *dso)
> >  {
> >       return RC_CHK_ACCESS(dso)->a2l_fails;
> > diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> > new file mode 100644
> > index 000000000000..e4bfd52bd172
> > --- /dev/null
> > +++ b/tools/perf/util/libdw.c
> > @@ -0,0 +1,153 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "dso.h"
> > +#include "libdw.h"
> > +#include "srcline.h"
> > +#include "symbol.h"
> > +#include "dwarf-aux.h"
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > +#include <elfutils/libdwfl.h>
> > +
> > +void dso__free_a2l_libdw(struct dso *dso)
> > +{
> > +     Dwfl *dwfl =3D dso__a2l_libdw(dso);
> > +
> > +     if (dwfl) {
> > +             dwfl_end(dwfl);
> > +             dso__set_a2l_libdw(dso, NULL);
> > +     }
> > +}
> > +
> > +struct libdw_a2l_cb_args {
> > +     struct dso *dso;
> > +     struct symbol *sym;
> > +     struct inline_node *node;
> > +     char *leaf_srcline;
> > +     bool leaf_srcline_used;
> > +};
> > +
> > +static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
> > +{
> > +     struct libdw_a2l_cb_args *args  =3D _args;
> > +     struct symbol *inline_sym =3D new_inline_sym(args->dso, args->sym=
, dwarf_diename(die));
> > +     const char *call_fname =3D die_get_call_file(die);
> > +     char *call_srcline =3D srcline__unknown;
> > +     struct inline_list *ilist;
> > +
> > +     if (!inline_sym)
> > +             return -ENOMEM;
> > +
> > +     /* Assign caller information to the parent. */
> > +     if (call_fname)
> > +             call_srcline =3D srcline_from_fileline(call_fname, die_ge=
t_call_lineno(die));
> > +
> > +     list_for_each_entry(ilist, &args->node->val, list) {
> > +             ilist->srcline =3D  call_srcline;
> > +             call_srcline =3D NULL;
> > +             break;
> > +     }
> > +     if (call_srcline && call_fname)
> > +             free(call_srcline);
> > +
> > +     /* Add this symbol to the chain as the leaf. */
> > +     inline_list__append_tail(inline_sym, args->leaf_srcline, args->no=
de);
> > +     args->leaf_srcline_used =3D true;
> > +     return 0;
> > +}
> > +
> > +int libdw__addr2line(const char *dso_name, u64 addr,
> > +                  char **file, unsigned int *line_nr,
> > +                  struct dso *dso, bool unwind_inlines,
> > +                  struct inline_node *node, struct symbol *sym)
> > +{
> > +     static const Dwfl_Callbacks offline_callbacks =3D {
> > +             .find_debuginfo =3D dwfl_standard_find_debuginfo,
> > +             .section_address =3D dwfl_offline_section_address,
> > +             .find_elf =3D dwfl_build_id_find_elf,
> > +     };
> > +     Dwfl *dwfl =3D dso__a2l_libdw(dso);
> > +     Dwfl_Module *mod;
> > +     Dwfl_Line *dwline;
> > +     Dwarf_Addr bias;
> > +     const char *src;
> > +     int lineno =3D 0;
> > +
> > +     if (!dwfl) {
> > +             /*
> > +              * Initialize Dwfl session.
> > +              * We need to open the DSO file to report it to libdw.
> > +              */
> > +             int fd;
> > +
> > +             fd =3D open(dso_name, O_RDONLY);
> > +             if (fd < 0)
> > +                     return 0;
> > +
> > +             dwfl =3D dwfl_begin(&offline_callbacks);
> > +             if (!dwfl) {
> > +                     close(fd);
> > +                     return 0;
> > +             }
> > +
> > +             /*
> > +              * If the report is successful, the file descriptor fd is=
 consumed
> > +              * and closed by the Dwfl. If not, it is not closed.
> > +              */
> > +             mod =3D dwfl_report_offline(dwfl, dso_name, dso_name, fd)=
;
> > +             if (!mod) {
> > +                     dwfl_end(dwfl);
> > +                     close(fd);
> > +                     return 0;
> > +             }
> > +
> > +             dwfl_report_end(dwfl, /*removed=3D*/NULL, /*arg=3D*/NULL)=
;
> > +             dso__set_a2l_libdw(dso, dwfl);
> > +     } else {
> > +             /* Dwfl session already initialized, get module for addre=
ss. */
> > +             mod =3D dwfl_addrmodule(dwfl, addr);
> > +     }
> > +
> > +     if (!mod)
> > +             return 0;
> > +
> > +     /*
> > +      * Get/ignore the dwarf information. Determine the bias, differen=
ce
> > +      * between the regular ELF addr2line addresses and those to use w=
ith
> > +      * libdw.
> > +      */
> > +     if (!dwfl_module_getdwarf(mod, &bias))
> > +             return 0;
> > +
> > +     /* Find source line information for the address. */
> > +     dwline =3D dwfl_module_getsrc(mod, addr + bias);
> > +     if (!dwline)
> > +             return 0;
> > +
> > +     /* Get line information. */
> > +     src =3D dwfl_lineinfo(dwline, /*addr=3D*/NULL, &lineno, /*col=3D*=
/NULL, /*mtime=3D*/NULL,
> > +                         /*length=3D*/NULL);
> > +
> > +     if (file)
> > +             *file =3D src ? strdup(src) : NULL;
> > +     if (line_nr)
> > +             *line_nr =3D lineno;
> > +
> > +     /* Optionally unwind inline function call chain. */
> > +     if (unwind_inlines && node) {
> > +             Dwarf_Addr unused_bias;
> > +             Dwarf_Die *cudie =3D dwfl_module_addrdie(mod, addr + bias=
, &unused_bias);
> > +             struct libdw_a2l_cb_args args =3D {
> > +                     .dso =3D dso,
> > +                     .sym =3D sym,
> > +                     .node =3D node,
> > +                     .leaf_srcline =3D srcline_from_fileline(src ?: "<=
unknown>", lineno),
> > +             };
> > +
> > +             /* Walk from the parent down to the leaf. */
> > +             cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
> > +
> > +             if (!args.leaf_srcline_used)
> > +                     free(args.leaf_srcline);
> > +     }
> > +     return 1;
> > +}
> > diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
> > new file mode 100644
> > index 000000000000..0f8d7b4a11a5
> > --- /dev/null
> > +++ b/tools/perf/util/libdw.h
> > @@ -0,0 +1,60 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef PERF_LIBDW_H
> > +#define PERF_LIBDW_H
> > +
> > +#include <linux/types.h>
> > +
> > +struct dso;
> > +struct inline_node;
> > +struct symbol;
> > +
> > +#ifdef HAVE_LIBDW_SUPPORT
> > +/*
> > + * libdw__addr2line - Convert address to source location using libdw
> > + * @dso_name: Name of the DSO
> > + * @addr: Address to resolve
> > + * @file: Pointer to return filename (caller must free)
> > + * @line_nr: Pointer to return line number
> > + * @dso: The dso struct
> > + * @unwind_inlines: Whether to unwind inline function calls
> > + * @node: Inline node list to append to
> > + * @sym: The symbol associated with the address
> > + *
> > + * This function initializes a Dwfl context for the DSO if not already=
 present,
> > + * finds the source line information for the given address, and option=
ally
> > + * resolves inline function call chains.
> > + *
> > + * Returns 1 on success (found), 0 on failure (not found).
> > + */
> > +int libdw__addr2line(const char *dso_name, u64 addr, char **file,
> > +                  unsigned int *line_nr, struct dso *dso,
> > +                  bool unwind_inlines, struct inline_node *node,
> > +                  struct symbol *sym);
> > +
> > +/*
> > + * dso__free_a2l_libdw - Free libdw resources associated with the DSO
> > + * @dso: The dso to free resources for
> > + *
> > + * This function cleans up the Dwfl context used for addr2line lookups=
.
> > + */
> > +void dso__free_a2l_libdw(struct dso *dso);
> > +
> > +#else /* HAVE_LIBDW_SUPPORT */
> > +
> > +static inline int libdw__addr2line(const char *dso_name __maybe_unused=
,
> > +                                u64 addr __maybe_unused, char **file _=
_maybe_unused,
> > +                                unsigned int *line_nr __maybe_unused,
> > +                                struct dso *dso __maybe_unused,
> > +                                bool unwind_inlines __maybe_unused,
> > +                                struct inline_node *node __maybe_unuse=
d,
> > +                                struct symbol *sym __maybe_unused)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline void dso__free_a2l_libdw(struct dso *dso __maybe_unused)
> > +{
> > +}
> > +#endif /* HAVE_LIBDW_SUPPORT */
> > +
> > +#endif /* PERF_LIBDW_H */
> > diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> > index 27c0966611ab..e2d280678b02 100644
> > --- a/tools/perf/util/srcline.c
> > +++ b/tools/perf/util/srcline.c
> > @@ -6,6 +6,7 @@
> >  #include "libbfd.h"
> >  #include "llvm.h"
> >  #include "symbol.h"
> > +#include "libdw.h"
> >
> >  #include <inttypes.h>
> >  #include <string.h>
> > @@ -51,6 +52,25 @@ int inline_list__append(struct symbol *symbol, char =
*srcline, struct inline_node
> >       return 0;
> >  }
> >
> > +int inline_list__append_tail(struct symbol *symbol, char *srcline, str=
uct inline_node *node)
> > +{
> > +     struct inline_list *ilist;
> > +
> > +     ilist =3D zalloc(sizeof(*ilist));
> > +     if (ilist =3D=3D NULL)
> > +             return -1;
> > +
> > +     ilist->symbol =3D symbol;
> > +     ilist->srcline =3D srcline;
> > +
> > +     if (callchain_param.order =3D=3D ORDER_CALLEE)
> > +             list_add(&ilist->list, &node->val);
> > +     else
> > +             list_add_tail(&ilist->list, &node->val);
> > +
> > +     return 0;
> > +}
> > +
> >  /* basename version that takes a const input string */
> >  static const char *gnu_basename(const char *path)
> >  {
> > @@ -120,6 +140,10 @@ static int addr2line(const char *dso_name, u64 add=
r, char **file, unsigned int *
> >  {
> >       int ret;
> >
> > +     ret =3D libdw__addr2line(dso_name, addr, file, line_nr, dso, unwi=
nd_inlines, node, sym);
> > +     if (ret > 0)
> > +             return ret;
> > +
> >       ret =3D llvm__addr2line(dso_name, addr, file, line_nr, dso, unwin=
d_inlines, node, sym);
> >       if (ret > 0)
> >               return ret;
> > diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
> > index c36f573cd339..be9f002bf234 100644
> > --- a/tools/perf/util/srcline.h
> > +++ b/tools/perf/util/srcline.h
> > @@ -57,6 +57,7 @@ struct inline_node *inlines__tree_find(struct rb_root=
_cached *tree, u64 addr);
> >  void inlines__tree_delete(struct rb_root_cached *tree);
> >
> >  int inline_list__append(struct symbol *symbol, char *srcline, struct i=
nline_node *node);
> > +int inline_list__append_tail(struct symbol *symbol, char *srcline, str=
uct inline_node *node);
> >  char *srcline_from_fileline(const char *file, unsigned int line);
> >  struct symbol *new_inline_sym(struct dso *dso,
> >                             struct symbol *base_sym,
> > --
> > 2.52.0.457.g6b5491de43-goog
> >
