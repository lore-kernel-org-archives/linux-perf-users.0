Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F72905;
	Sat, 23 Nov 2024 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732323488; cv=none; b=clMYxdoWRRc/VDA0sfhJ+h3T9bh9IWP/2A3cXAw9XIPWKtRsfEZtkJHqH8M3CkyiH5QjQBqARc3g0cHmAYZErbzG9nRogKL9931SX5gmkYL89SQK35FPkB6dRdTVXQcCcJFnW6vQ8G2iBUKI9h2kunH2QrVYeyZExCGb6LenKjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732323488; c=relaxed/simple;
	bh=DwFjvp3LrpUpeBJB47qEo/UaYvoRqDdQOmRBSbyN+E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7SouCRPXLkzATTsB6DMvAZqd9adqed5WGBS1F6BgNePawKFTDF8KEr2c03QjsxjO93aF6R0tu1/qolmyjnOhAP1SChDOlY6QFVjfFgGCpBgVcAcwtbwKCbHR29yx4ht39RQswjJ4fRiVDtVUcWyB0mxMmq9RIt2Mj3VIHaHnDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg3DsXD7; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg3DsXD7"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e382661fb79so2310690276.0;
        Fri, 22 Nov 2024 16:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732323485; x=1732928285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjPNDocQul8Z5NafjwYaP8O0UL5kL4VcdW/j1433320=;
        b=Rg3DsXD7nWIhUdAdT7T3DWuAg74t9/c6RI7TBajvCepEDIaRgg9cNy/IG3p/Xjej9O
         POmynC039GwMJd9tKTwRiRLYKckrZhb6WEJGlNINaAOOOJ0mY2abQK8JI9dw4M6/RAEr
         rUP+mMLDjmwvbc3pK5cDvtO1V6i4eX49ANxbpEc5+ZirIeOEsLiMgwzrKzAGMeY1l3Jx
         Azh8WZTylBinavH31uQuJN3OAS/DBs6M6abpWagxM/A66mfGPDptzm9ATmkjHmAgv3H1
         qkiGJOEbGFNjhO9OqJECEVbOo53N+TTWM2SWqEbw5Kj2seODe/ZuGmQ7R31yJwnrVDcK
         C3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732323485; x=1732928285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjPNDocQul8Z5NafjwYaP8O0UL5kL4VcdW/j1433320=;
        b=guJlKFZBNml7dOdjkt6f9L0qebuWbYJrgUa99VtSWpqKm/kCAgB0S4eh0PvaWxgwuy
         Nk3KjZkmu0RX/jn5V1RjuXMWFDrc3lvwjLEYpBx/1XWRS9R/sw9WsBI5r1j4/9s9HNTF
         Kzat1Wbf9bkfm2tjY15hfyuwdgVf1zLnpP3g/9LFPW0nTnHInWMj3PEF2Ko/1Abi4OFs
         Xbulr5cjJcP6pkRoRWnv+CdTUQkXFTQpmZmvbih0qdbPnGrF3Rb3xcwEvSP4ZNBTesHV
         74CjZ6Hi1IAnM/D6Glt8pdt3v3c3l59gHi9kWRJ9CNlXfFz9dalOk2Vbrd+oj1hTduE1
         kHvA==
X-Forwarded-Encrypted: i=1; AJvYcCVap+7mPWsknAcCV1MjjqxH+mhw5GRfY2xbJ+VNh/lpm7JCXrQfvyQPpmGxrj2fVKIuYkxMFUZX1RZyu/w=@vger.kernel.org, AJvYcCWkdf50q8+gNhULRYO8fCh1c8BOOEaJzrLGzfyZ/JIUmOQ+VwlvgmQcYfUWjNrGJUShUekDG7U3ltIn9n0yRPW5RA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/dNI3+nxHn+cKW9P75/TAAvl/rURoPfIBAYFktDdpM7cX++c
	DvwESVhxuhBdiQ0zGIrfCfh6pgn37QBVJc51ArsCU0ee4siYJQk9Xetd5Cfh6qT7J9iOVhvBueP
	UFP0w54aOpcEuq//oh6l0zSxOMxU=
X-Gm-Gg: ASbGncvMdhVyAHe69OxeeFAxtVnXi8RQYcNih5ner53UMD9GjiXDqGks8GVNfgWAR6T
	28rZVgnj17/abeiL+8YC1d2vGCbtDrRl6
X-Google-Smtp-Source: AGHT+IGw2h1Xh25R+Bb58ZbiscxcwNkZB/4AvE5Srlwo1QGbXnfMe/X+789oD7dAiAew+MMa1wRTr/wNEgWAGk1c/SQ=
X-Received: by 2002:a05:6902:723:b0:e30:d516:e0ea with SMTP id
 3f1490d57ef6-e38f8b343bcmr5232015276.21.1732323485468; Fri, 22 Nov 2024
 16:58:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123005512.342079-1-howardchu95@gmail.com> <20241123005512.342079-2-howardchu95@gmail.com>
In-Reply-To: <20241123005512.342079-2-howardchu95@gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 22 Nov 2024 16:58:00 -0800
Message-ID: <CAH0uvojmPp4-0xb6sObr8Tcw=ujysLMBeebpwON0Ygy=LH63Zg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf trace: Add tests for BTF general augmentation
To: peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the first patch, there is:


Suggested-by: Ian Rogers <irogers@google.com>

Thanks,
Howard

On Fri, Nov 22, 2024 at 4:55=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Currently, we only have perf trace augmentation tests for enum
> arguments. This patch adds tests for more general syscall arguments,
> such as struct pointers, strings, and buffers.
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 68 +++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
>
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tes=
ts/shell/trace_btf_general.sh
> new file mode 100755
> index 000000000000..7bcca81a40d8
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -0,0 +1,68 @@
> +#!/bin/bash
> +# perf trace BTF general tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +err=3D0
> +set -e
> +
> +. "$(dirname $0)"/lib/probe.sh
> +skip_if_no_perf_trace || exit 2
> +
> +file1=3D$(mktemp /tmp/file1_XXXXX)
> +file2=3D$(echo $file1 | sed 's/file1/file2/g')
> +
> +buffer=3D"the content of the buffer"
> +
> +trap cleanup EXIT TERM INT HUP
> +
> +trace_test_string() {
> +  echo "Testing perf trace's string augmentation"
> +  if ! perf trace -e renameat* --max-events=3D1 -- mv ${file1} ${file2} =
2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ r=
enameat(2)?\(olddfd: .*, oldname: \"${file1}\", newdfd: .*, newname: \"${fi=
le2}\", flags: .*\) +=3D +[0-9]+$"
> +  then
> +    echo "String augmentation test failed"
> +    err=3D1
> +  fi
> +}
> +
> +trace_test_buffer() {
> +  echo "Testing perf trace's buffer augmentation"
> +  # echo will insert a newline (\10) at the end of the buffer
> +  if ! perf trace -e write --max-events=3D1 -- echo "${buffer}" 2>&1 | g=
rep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +echo\/[0-9]+ write\(=
fd: [0-9]+, buf: ${buffer}.*, count: [0-9]+\) +=3D +[0-9]+$"
> +  then
> +    echo "Buffer augmentation test failed"
> +    err=3D1
> +  fi
> +}
> +
> +trace_test_struct_btf() {
> +  echo "Testing perf trace's struct augmentation"
> +  if ! perf trace -e clock_nanosleep --force-btf --max-events=3D1 -- sle=
ep 1 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +sleep\/=
[0-9]+ clock_nanosleep\(rqtp: \(struct __kernel_timespec\)\{\.tv_sec =3D \(=
__kernel_time64_t\)1,\}, rmtp: 0x[0-9a-f]+\) +=3D +[0-9]+$"
> +  then
> +    echo "BTF struct augmentation test failed"
> +    err=3D1
> +  fi
> +}
> +
> +cleanup() {
> +       rm -rf ${file1} ${file2}
> +}
> +
> +trap_cleanup() {
> +       echo "Unexpected signal in ${FUNCNAME[1]}"
> +       cleanup
> +       exit 1
> +}
> +
> +trace_test_string
> +
> +if [ $err =3D 0 ]; then
> +  trace_test_buffer
> +fi
> +
> +if [ $err =3D 0 ]; then
> +  trace_test_struct_btf
> +fi
> +
> +cleanup
> +
> +exit $err
> --
> 2.43.0
>
