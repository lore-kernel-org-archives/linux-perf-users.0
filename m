Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794779905;
	b=YyDno5A2ZioMhhcZdSUuPtvDAeWaVC7mTTmPdG2P+LJ9ZH8FQz/b0yQ1PtGPaoI2OxSQ
	 L0brkzKxYjljjs3zAmXfrZAzOsCpYoL2q7m0QFr9uhEYUJBUDFp/thPPT43+n6iJrzHdl
	 Gh0/J2ibQVEDhJXmt6Oup2JmchNic/buNCZ1RI77NzD/kkzWAJjvVCPhTU59SfHShv8rn
	 WlXUjB+QzrZgSVkthIPVrhs0NDioGbGo9IUE0weo6bBdzLeuwMYmc7Yr/XC14irddUwH2
	 tpkkCutdQSUYrJ5jhN4LMOpJxzSmuF1NBhJ9DTAMSk+IWSTAY4713dMgyra+mfapsww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+T++C8/Le21U95CJVDo3LG6rDxqw06NJjus3xkKM//U=;
	b=GElaqwETcQp084wcame/Qgjt6989q6Ss4Mkh+oV7aR6uDlBs1CgUDFYgB3g/yjT2wdSV
	 SuLQtgm+pZ6aTTmqAVtp/xkoFn5N8GCHZfgbt22UMvxSY+sLiQIT+2hiYcvGSFoiChqSU
	 1Zz65QfTfA9HY6cmpd9/P0JAFVEOap8JK7ETerzjE5DEvGg1zJ/tG7kxfoo6PWaczC/Am
	 Z6Zq0yw9imM0HgEYu65bCHmwrLBD6a7tcjfeJLVHkCgc1WSnFGx8/rJUDpIIv9wSNhYT4
	 Qud+Ia6RKLyAL1rZDGxaerjUDN8t9xfa0aM6m96p8Cyoc/BXhypV5qk7qpXX0EUSAnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b0kC65AC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119D606A338
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 21:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4119D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b0kC65AC
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55c7445cf85so209421cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 13:58:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794779904; cv=none;
        d=google.com; s=arc-20260327;
        b=SbdsMW761Zk9yeO+bXGmA6BdG9L1irxhpig3GiVh0sOfEtqYMA/QJzeDH2WJRSQz/C
         yOCw2bdB8zpH3K3gOF4oZr37TUv4eSju/UEmmjCYKJKj+Q9DoVTYT7mSxTPyO+1AlTFb
         3XOOquTlraWKDRNYd6OlwFYnyxcjQ+4UDuZeeE47RTqgmg5pY93EaTcq+M2j/mPlwLCl
         4lmUfwTay0Q4QBKgD+zHQXDvCHM2qIQo+69CiyIPSIBs3rnknzR5BqGFzLpqCUk2TJhW
         Y2t5ZRPY+jTtTEqlLThaosnzSbaiYL+Yl5Enyi0w80xrV+9qQiVUxipH8bMNKvA11jD6
         0IxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+T++C8/Le21U95CJVDo3LG6rDxqw06NJjus3xkKM//U=;
        fh=BGx2ZwiPWLWeGeObE+pHjGqFE9p6Y5UXIwz5Ep7v+Ys=;
        b=qS7NWdo43J+rRZA2rJ7UYMi2MaPNiqhG96V/p91LhS7A2kF1EH5j0YwfG/gtqX8pCM
         2eol+0FYCTiGq2+5tTgDcc8FJtMOcX3psGPZ5zu9Z8/gpqE18LDrvhGUQ/Sd8dXCWH4E
         IZY8djlPBWd4xgN/az1jc8jK1AG6YAkt7+lLN2HPLnirnsNJEongabOqNnBC5uG6fiW9
         /qQ9rwmAB44WWEk5g0C7UuoCfHOCEkMDhFgSdh0YE+zh2i6X25j6fkRSJToAKFWf6f1G
         aOCejsG8+oMB+9CwqB4x31ildMf6wVjPuVIB4PslzwoaOO1MBr1iDB+gx1qQl0WfrYhD
         qVxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794779904; x=1795384704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+T++C8/Le21U95CJVDo3LG6rDxqw06NJjus3xkKM//U=;
        b=b0kC65ACz9WrilvFFKo7Vtu1BTzxe71GggS7rjoyDbNYO8DZZ93vwxJSZ6oZy551D+
         EUyx2l/u3N+Q362VuIjgqvzKKrrLkixb8z8k9F+rKQpV1pQhON5lTaYHmikQGrrwJBjy
         7QCnZMz4WeVPAQtQLR+Jm3mWc6Up1F17VuQOl218OWKFYkSw4jLPUhyVPnFG2A2FwKbj
         pD6wqe47h1eU4CYzEo7h38xUOEhg1dzDc7oJzaz7dvgEyyW4YjCKx/l4TrOTcKB2Xi1u
         R/nrGJImRQlJg2PaErvJQ8/30+ErjZzJJ+sHlVgsHSr1IyJ+5FAgXhf5Yxw7/rN5OOtR
         vamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794779904; x=1795384704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+T++C8/Le21U95CJVDo3LG6rDxqw06NJjus3xkKM//U=;
        b=GnBGbYWrugzLrAVX+IqaBIxT5m9IjhXIn9aaUi9MPvMD74rmQ523V5JA3e2Dbv/Ngo
         sd8LZBFzZjLzImxPZzP1iCtTWOnvi6G+YOCSt+hqlAGq1Jiv6cZa7AM9V6BYmlSaZxZC
         Fe+tLeuOl7cNxHCGjH4XgYltsbP7pOOBqZrS6s0HHL4OOoWBlt8Qru/n9rpRmI7iXvei
         KSgz72p+UNWccScZOJHhYC0HRxXgu8ueM+yeKg4MpoQxWumQL0Dq8tirYeD5WecSnq9O
         N7dRIhemwZnboULH/rP3nbAZhhnDvdRxGgJI6MvbOmokpFH26/kuR8404WESzfCPyO+3
         Lgkg==
X-Forwarded-Encrypted: i=1; AL+hErFxejmVDM4L/X7Dz63ScJzXUOPBw1X5QvXoJhoZwPje4rUPyHrUVQdt0XGzXxJXvR8+EflstEBEFJLreAYY3uvq@vger.kernel.org
X-Gm-Message-State: APuU4Z8nMLS8GlJ/bqFznKjDAHIJ4jzbaiRArbZNb1tASWdsUTizGIVR
	m54YnK/0YT4RbZ2aRWRznRYCr5HVvTDAiWle8ijrsti+V3FqZfQWZOCxtxWkHDKdB1c1x4yWy/w
	7IubiKu5HmF1qesJ6Gs+X3B229GlsWDJlySZWVNwo
X-Gm-Gg: AYBFou3KN7+ReqKML3cKzhxGxVXfCo/pc9U0ZI/cZPIZ0bl2Nd/rcrxA5YOd6Yj4P85
	J3LhIOv30C+Y+job1wvKsixQyAndxGekymZy3IfYTQeiUJwq/9xN2Ltm2gyRQDU70wNMOrg2GCS
	sa25iaRKzSTm6yjT47nn+i5wULgXLRdI5x/B9PSU3euES4s8/D87xS2y8PLPYNqPANtx4uokem5
	Yl2LuZIUi7uMfQ0bC/F/slPCIYv0hgSEHLIvVfRs6/LMrT6T4ihHiMreoLuZfd7kv1OnP6b/p2v
	NoZo+6YArwJxIO31IlYcPassvYqjvAktcUr/dGdxvzpqjzjxL86Pzbx/dPa2KvGNebTn+p2aXMX
	FfOS+AbdKgTBx79Six1LbIHBJkqNWRUu/0sWl
X-Received: by 2002:ac8:6908:0:b0:55b:ce7e:e65 with SMTP id
 d75a77b69052e-55c67fb2932mr26884471cf.12.1794779903529; Sun, 15 Nov 2026
 13:58:23 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115014102.2879372-1-acme@kernel.org> <20261115014102.2879372-13-acme@kernel.org>
In-Reply-To: <20261115014102.2879372-13-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 15 Nov 2026 13:58:12 -0800
X-Gm-Features: AclHuK8OXB8NJ9-NAD6M7-X6jeEmjE9CNS0p7XpfdI_YYAbd_rSTJBm9F82s3Uw
Message-ID: <CAP-5=fUmNrya+vyzCVWVknQnHtphdnJt6itYBkWnkY-M_jh55Q@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] perf test: Skip the LBR inline unwinding check
 when unsupported
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 5:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> The check only looks for the PMU's caps/branches file before recording
> with --call-graph lbr.  AMD BRS advertises branches but only samples its
> own retired branches event, so the record with cycles is rejected and
> the test fails instead of skipping.
>
> Probe the record and skip when it fails, as the branch stack test does.
>
> Fixes: 446c595dc0dd ("perf test addr2line_inlines: Ensure inline informat=
ion shows on LBR leaves")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/addr2line_inlines.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tes=
ts/shell/addr2line_inlines.sh
> index e8754ef2d7f21ac2..6fe47909dae4f812 100755
> --- a/tools/perf/tests/shell/addr2line_inlines.sh
> +++ b/tools/perf/tests/shell/addr2line_inlines.sh
> @@ -71,7 +71,14 @@ test_lbr() {
>      fi
>
>      # Record data. Currently only dwarf callchains support inlined funct=
ions.
> -    perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- perf t=
est -w inlineloop 1
> +    # Some PMUs advertise branches but reject branch sampling for cycles=
, e.g.
> +    # AMD BRS, which only samples its own retired branches event.
> +    if ! perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- \
> +            perf test -w inlineloop 1 2>/dev/null
> +    then
> +        echo "Skip: LBR not supported by the PMU"
> +        return
> +    fi
>
>      # Check output with inline (default) and srcline
>      perf script -i "${perf_data}" --fields +srcline > "${perf_script_txt=
}"
> --
> 2.56.0
>
