Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620A4963BA
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499963; cv=pass; b=bnMg7BW+pQnYn0DU62IXqKio41iYrvza1DEu+/7MRyk94gLfK7uXZjtCnX1XesPaz+dTOrXwxk+x38zE+jfZLycK+CUfb06Y7GprALg+4TBUENc3u8zflP31qGU8gFO2JBcwWa2fq4NHuRpTVsXj/CT4Nn27F/nW35LFm/SGQXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499963; c=relaxed/simple;
	bh=dYcGfqYfr1vZ9LkR0r2zi70tyUkuGJmFUl5d0gpt6pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKALaNHI4YYxPvnPlj6lfhICOBILGjfpLEpZudm8+jvEVO5lvpUIw0q1BEH71Sj0r8Qp3FQhJsIlPRsUDnFTlGNasAUrnhdq09wcLXyP69q9jh6K0jZYCy738nebj+EJ9M8bmMxSXb5AQcGZRxWtnXUKV7fY7K+l2Mt6+Q0m2kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxlyLiC7; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxlyLiC7"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf2911f93cso70045ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780499960; cv=none;
        d=google.com; s=arc-20240605;
        b=DQKQ7FUflSk89506uXp0AUunstbiBTW1//TFsSwZaMYvXfH9s6L8xICe4XgcILkBVl
         NN3hCnSp4E6ke/de04EfccX+2GsOHXHU2L/3DusWoFUx8AZS80dAv5ObIZWN1VtJP0Xw
         t+T9iyaCr9KjHjg2DthG8RvkxPLftGU39SkTSe2YTqYFLhqU8BUgaPNWeQyN1VhuO/1A
         hAFxEKmHRx9C8GLYEgf48R6C06fVhltd0OpBq6M1gM/NneXctcyHY7VAzlO6v37gFkn1
         +eLbePpdG4sMkJNDvyhDcudBzBfvGrzUVC68/tiTiTPalspaK23nVsP8pF7+//mkxhc2
         Mhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RBv39v9B7TeMOI10362p++zoGC00hzGeAK2V+OJssRA=;
        fh=4YSCyodne9SYBHCggk24vYDbqP86nF/ZUkwTtqR8bd8=;
        b=a6UIZjZ1jdx15exbg37kpBBl1cqJL+VXNtpshmzKAww2MtingjhPBW51LWKmRB90wD
         i3IPR6FkuE5bk0JG8Ndjx1jydXlwfocjhSLiOfcNncWQ5iupQTmQ1egBhDM3bU2TJrt9
         yEsBt4j9EynSMyJZj6Z2b/2AioLW+MNN9Uwuikd6o/DmMqmDZ5MEErtqfxAtjHrYjOq7
         ohS7VgsH3fLCTqm3hO/LXYVIWXh0vEpjWhEbDEbcTfsc+HRewsWLJ/FHju/vD3nkNQGA
         9mvLGBFVuN3ImuVLSbRp4hwd2HtE9XVujTpZwzhmGkupTNQ5xISqM+WfcRdlA+4Cg98a
         ZFEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780499960; x=1781104760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBv39v9B7TeMOI10362p++zoGC00hzGeAK2V+OJssRA=;
        b=UxlyLiC7zMjb7DEthaD4NbQ7RheD4mv/1PL7mZNd8hR99zdZlZgafoOxoGhJIc38dD
         nN3/ZgDvIwP5v/nLBIhrWKnB/dxv9Kmip+FNrdrKftywbcOeQDQNOQJ+jfZgeqfw4X3b
         wYvJEGpvgVEf5i4QPL4XWEr1XSUuzMaWePhZRhPxOQPeugzmP1LY3YTRpWedIMG9nOSn
         x5I6X0ur1cxOZDRl/fHx4NZAFZToxOWUDWmL0E34kVZTAc5GjxoNDcuZp7ePhdPODiEe
         8AJhD0H9LdWkujn9k7R5UE8nFKrJuWu4JXuz/M1OJCFizXLj63i++YdRBNfdCAZADbGE
         T/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499960; x=1781104760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBv39v9B7TeMOI10362p++zoGC00hzGeAK2V+OJssRA=;
        b=iVzi6/zizWDrgxsQ1yzJVshaL2WwquW565dJn6xLgjnYGbgTtZQLhYEwxkCqJDNOwz
         rUPHABhFI2qsrmHNY3+sO70B382r67ZExoET8y39Pgo1IsWv3cMfkbk2phY+OjtumVTW
         SzhPGz6NwHP3IP8eSiJ2EpcM4j9V6EdAEr35dcyP8j3e3YZEBKv/R7X03E/bIkwBp8RU
         +b2qv2NsX4Msms9RArO4ey0nJ4G6naHZCQey4m++2nFKkPjD6aAR7y5J+ulG5WUzbDpn
         tBmX0gKcV8c0pKZNmrKGKU0f5OuHIx1Lp2NmAXLBqrcwjBYBhtg66Ey4OmaZrznJIZl8
         aq2g==
X-Forwarded-Encrypted: i=1; AFNElJ8QP8BJyHl0kV0iyW8xh3cVdQ0TiCwWQMNy3Dm4aEwg+Y5IhFBjMpuwYwYcQoy0MoqyFUN91wI/LuKlwv4rWAUF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Bx50vbvDitb4Tq8WLjXw8K0LVHbLzunZeBL4AvDP2G2g9LEP
	Ta4jxCnfYNimMqI5p6cZ1t3jXMmjMG6GyYn5Y2jufSeBOHTDz3rs8iUDxlSWtj+hrl5TsYLlrbf
	9TMzof05GJ9077dWzi6/uFavM9mQdUF/Ce5ENLukP
X-Gm-Gg: Acq92OFH8W6mopQCtSbKhCicKo/z2sYxDD7wa0iZZhRCAX9+hVMREpJ461qUdURJVgR
	8lrxpkqGH35BeRNCq3cBLoS8Z5W7CMi1iCNe78Ctfhiw354Bb0hsrSKbuTsxqZeFBtxVFvxqL5K
	HTM5tYuIC2TR1BCBrEVfosoEbityxAjpUPjCm5eJ6gy4/bdTkfeBpVJSqMmli5zXDk6Wxtuv/EU
	Ux+sMQoZmQ4of7JX1FqZO0j2qgqsZpbS3Ruqkc6/NrDFJ1t8nePZFTdji5IyUksjWEvXCMr9xML
	Puc6jSlkglOj4omxsfqgXhugkqfJT6etBMNpnxdzQcffzHtQ
X-Received: by 2002:a17:902:ef43:b0:2bd:6dad:3df9 with SMTP id
 d9443c01a7336-2c16fb58110mr1976755ad.23.1780499959933; Wed, 03 Jun 2026
 08:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235709.1541603-1-acme@kernel.org> <20260602235709.1541603-9-acme@kernel.org>
In-Reply-To: <20260602235709.1541603-9-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 08:19:08 -0700
X-Gm-Features: AVHnY4Ln7NqA50-ySXf_O4j2x71HR23d6ZJ5m6B7ia_jgTUmuJ-smXN4dpHkkjQ
Message-ID: <CAP-5=fU3UYq6XyhbnkpEcf4EtJ=42OcBDqr2GU2i-Ur4sLF7Sg@mail.gmail.com>
Subject: Re: [PATCH 8/8] perf test: Add file offset diagnostic test for
 corrupted perf.data
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:58=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Add a shell test that verifies the file_offset diagnostic messages
> work correctly when perf encounters corrupted events.
>
> The test corrupts a MMAP2 event's size field in a recorded perf.data
> file, then checks that perf report produces warning messages that
> include both the file offset (e.g. "at offset 0x2738:") and the
> event type name with numeric id (e.g. "MMAP2 (10)").
>
> This exercises the diagnostic improvements from the file_offset
> series, which retrofitted all skip/stop/error messages to include
> the position and type of the problematic event.
>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../shell/data_file_offset_diagnostics.sh     | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100755 tools/perf/tests/shell/data_file_offset_diagnostics.s=
h
>
> diff --git a/tools/perf/tests/shell/data_file_offset_diagnostics.sh b/too=
ls/perf/tests/shell/data_file_offset_diagnostics.sh
> new file mode 100755
> index 0000000000000000..031f49480d999d8c
> --- /dev/null
> +++ b/tools/perf/tests/shell/data_file_offset_diagnostics.sh
> @@ -0,0 +1,82 @@
> +#!/bin/bash
> +# Test that perf report includes file offsets and event type names in di=
agnostic messages.
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# The file_offset diagnostic series adds "at offset 0x...: TYPE (N)"
> +# to all skip/stop/error messages.  This test corrupts an event's size
> +# field in a perf.data file, then verifies the resulting warning
> +# includes the file offset and event type.
> +
> +err=3D0
> +
> +cleanup() {
> +       [ -n "${perfdata}" ] && rm -f "${perfdata}" "${perfdata}.old"
> +       rm -f "${corrupted}" "${stderrfile}"
> +       trap - EXIT TERM INT
> +}
> +trap 'cleanup; exit 1' TERM INT
> +trap cleanup EXIT
> +
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX) || exit 2
> +corrupted=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX) || exit 2
> +stderrfile=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX) || exit 2
> +
> +if ! perf record -o "${perfdata}" -- perf test -w noploop 2>/dev/null; t=
hen
> +       echo "Skip: perf record failed"
> +       cleanup
> +       exit 2
> +fi
> +
> +# Find the file offset of the first MMAP2 event via perf report -D.
> +# Format: "timestamp 0xOFFSET [0xSIZE]: PERF_RECORD_MMAP2 ..."
> +mmap2_line=3D$(perf report -D -i "${perfdata}" 2>/dev/null | grep "PERF_=
RECORD_MMAP2" | head -1)
> +if [ -z "${mmap2_line}" ]; then
> +       echo "Skip: no MMAP2 events found in perf.data"
> +       cleanup
> +       exit 2
> +fi
> +
> +mmap2_offset=3D$(echo "${mmap2_line}" | awk '{print $2}')
> +mmap2_offset_dec=3D$((mmap2_offset))
> +
> +# Copy the file and corrupt the MMAP2 event's size field.
> +# perf_event_header layout: type(u32) misc(u16) size(u16)
> +# Set size to 16 (0x10 0x00 little-endian) =E2=80=94 below the MMAP2
> +# minimum, which triggers the "event size too small" warning.
> +cp "${perfdata}" "${corrupted}"
> +printf '\x10\x00' | dd of=3D"${corrupted}" bs=3D1 seek=3D$((mmap2_offset=
_dec + 6)) conv=3Dnotrunc 2>/dev/null
> +
> +perf report -i "${corrupted}" --stdio > /dev/null 2> "${stderrfile}"
> +
> +# Check that warnings include "at offset 0x..."
> +if grep -q "at offset 0x" "${stderrfile}"; then
> +       echo "File offset in diagnostics [Success]"
> +else
> +       echo "File offset in diagnostics [Failed: no 'at offset 0x...' fo=
und]"
> +       echo "  stderr was:"
> +       head -5 "${stderrfile}"
> +       err=3D1
> +fi
> +
> +# Check that the event type name and numeric id appear: "MMAP2 (10)"
> +if grep -q "MMAP2 (10)" "${stderrfile}"; then
> +       echo "Event type name in diagnostics [Success]"
> +else
> +       echo "Event type name in diagnostics [Failed: no 'MMAP2 (10)' fou=
nd]"
> +       echo "  stderr was:"
> +       head -5 "${stderrfile}"
> +       err=3D1
> +fi
> +
> +# Check that the reported offset matches the actual corruption point
> +if grep -q "at offset ${mmap2_offset}:" "${stderrfile}"; then
> +       echo "Correct offset reported [Success]"
> +else
> +       echo "Correct offset reported [Failed: expected offset ${mmap2_of=
fset}]"
> +       echo "  stderr was:"
> +       head -5 "${stderrfile}"
> +       err=3D1
> +fi
> +
> +cleanup
> +exit ${err}
> --
> 2.54.0
>
