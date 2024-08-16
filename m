Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DFE1877
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723778165; cv=none; b=kbzLMZTmjeKT3ieIHISdEWZO9LK0zuTzlzLM3NLI86LRTFJo2Du3Ppk4fwUVHkclGMDDB5fKAxSZZsDDKOfAn1taNg2i9j9IPFcXqSpGzXibFhsPDMKBM4qhOcSlVroPuTUEWlkaYjDV67n7HzkrqKGXCAll2AojbOLPFqNEf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723778165; c=relaxed/simple;
	bh=QvgCRCVIJQlf3c9D/c6CQexGv/AVEDoPki6TZ6C+lgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXK7PPbYhzJsK5aINc0ldN4oNZXdUQljvGUnwS9jpJ8Rg7Qfb6guzYEkCKW++bccjh0Adkwzw8Cqh2kubpOkKlzJCxE1KmXZboCgaTI7bXQjcis6OihzCXt+dG3znhPRMpFcoEZtUApTDyNIm+XMV7rAn+KpU/7v0RDUhhr5w5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2SFQMqCU; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2SFQMqCU"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d2a107aebso18845ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2024 20:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723778162; x=1724382962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBDLm5A+RDH4WkOIu6haLqh5HgWheaTx6ZttayiUTD8=;
        b=2SFQMqCUIpkJUZxtgzkCIqfZ97iypt9gOlvR5s0M9Cvu5BZ9+9pCTp151Fgwju2Qsr
         GBIK4zCxXRBk0q/phrcpYwJ9Glm1GWm548wFw7sn5WIQ/RX36tQNlCDWnzwXa/ZtIzZW
         TJKubAKN1e8wQidEd1H/X+R8unfofl/eb1I0APcO/KTcw8g3he9coVhf1rncCdK/q5J9
         YQNZomjSXDxDr9ahVKeKZaGj4Knuj2eSSpUcSyeHlA+6dD/sytegWuBn8IfGntopML7w
         +MQLYf5BSlTIfWZ4yrG/BtravblKaVcCud1GaWL1/P1AcOwWUSZTmfNMilXycQoyHgGA
         X7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723778162; x=1724382962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBDLm5A+RDH4WkOIu6haLqh5HgWheaTx6ZttayiUTD8=;
        b=wEaXPLItxcxabwVU4Rs34X7YTEHNeCuRbFYczwfxeR+5uA3gxpJ/0OdJYHNcEsdMPm
         5arJ+78SvluQ0/y5fXmHGfllf6+ZQsG+Q7j19GnREF16y2lMurVEPGZxll8VGyGxC8Du
         hd/tg0pj7TaaWup2wKvfq/vatoz3pxnX/kn6YBvqmNLdLXFelIUAjLE3Y9349AfDrUst
         jEXjvbnIeru1nvdiQiop0eCsNnY3szLBvzaZzuDYBJb2cwSHQf9lHDIVYB1tyK8WlZjv
         xTkUF3hmSPymaJqG1Mxg7EhWNxSYeI50kdISoOmT5tH3o0M/9BW0ig2+a4fTXnRbo/6W
         YOsw==
X-Forwarded-Encrypted: i=1; AJvYcCUr1ObQ1w0TJ9Jvg4yccSaBREzaFGlG3Ks0Xbz7z2xdTEbfGlNfFOao9enBTbEyYaDqz2N+Lxuh5jd9e0l9vi5AvhKywNWB1qBpE/cgBBk/SA==
X-Gm-Message-State: AOJu0Yyy40QT0a2F+b9xmhzlsvZJHqmc4uBwsxosjqWnqltsI/BRhu/x
	JQpMWtfwTxQ2JAqml4A/zGBDGYLwYjqhKWPQdhTzO3TYN5N/AeIhVuqo8Ugb5/FNZUwaHb6W9rW
	YyaLrAAxwNOmUvRjtVij/0dJlTh0Q035bEsf/
X-Google-Smtp-Source: AGHT+IFG54skZod88kVSUZv1syt2i20zv5Fvy6Kdg2iPfl7E7+fCdF6DLOt5umNOo0pJ6e7zslmiGSByBIx+/w+nThY=
X-Received: by 2002:a05:6e02:16cf:b0:39a:14f7:1bfd with SMTP id
 e9e14a558f8ab-39d28eecf1cmr543285ab.5.1723778162148; Thu, 15 Aug 2024
 20:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815013626.935097-1-howardchu95@gmail.com> <20240815013626.935097-11-howardchu95@gmail.com>
In-Reply-To: <20240815013626.935097-11-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 Aug 2024 20:15:51 -0700
Message-ID: <CAP-5=fUqU0sKKNaQmA=ra0en3Mky_PvRu=-48E5Q-6Wov7_UNQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] perf trace: Add general tests for augmented syscalls
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:37=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> In this test, augmentation for:
>
> * string
> * buffer
> * struct
>
> Is tested.
>
> Please use this command to test it out:
>
> perf test "perf trace general tests"
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 59 +++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
>
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tes=
ts/shell/trace_btf_general.sh
> new file mode 100755
> index 000000000000..9c5e9d321b42
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -0,0 +1,59 @@
> +#!/bin/sh
> +# perf trace general tests
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
> +buffer=3D"this is a buffer for testing"
> +
> +trace_test_string() {
> +  echo "Testing perf trace's string augmentation"
> +  if ! perf trace -e renameat* --max-events=3D1 -- mv ${file1} ${file2} =
2>&1 | grep -q -E "renameat[2]*.*oldname: \"${file1}\".*newname: \"${file2}=
\".*"
> +  then
> +    echo "String augmentation failed"
> +    err=3D1
> +  fi
> +}
> +
> +trace_test_buffer() {
> +  echo "Testing perf trace's buffer augmentation"
> +  if ! perf trace -e write --max-events=3D1 -- echo "${buffer}" 2>&1 | g=
rep -q -E ".*write.*buf: \"${buffer}.*\".*"
> +  then
> +    echo "Buffer augmentation failed"
> +    err=3D1
> +  fi
> +}
> +
> +trace_test_struct() {
> +  echo "Testing perf trace's struct augmentation"
> +  if ! perf trace -e clock_nanosleep --max-events=3D1 -- sleep 1 2>&1 | =
grep -q -E ".*clock_nanosleep\(rqtp: \{1,\}, rmtp: \{1,\}\).* =3D 0"
> +  then
> +    echo "Struct augmentation failed"
> +    err=3D1
> +  fi
> +}
> +
> +cleanup() {
> +       rm -rf ${file2}
> +}

It can be nice to have a trap handler clean things up, as well as to
say a trap happened (as will happen with any non-zero exit with "set
-e" above). There's an example here where the function of the trap is
printed:
https://lore.kernel.org/lkml/20240813043439.933329-2-irogers@google.com/

Thanks,
Ian

> +
> +trace_test_string
> +
> +if [ $err =3D 0 ]; then
> +  trace_test_buffer
> +fi
> +
> +if [ $err =3D 0 ]; then
> +  trace_test_struct
> +fi
> +
> +cleanup
> +
> +exit $err
> --
> 2.45.2
>
