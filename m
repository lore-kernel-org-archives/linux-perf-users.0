Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FB01CF7A1
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696898; cv=none; b=gP9GhEgve44IPfGRge+tqxoBSliPShIA3QIl7lRZDa2ogzcrzJiULqZ9tsvWwW0iq0VKagU8r9vACTb2ArR1ADhoA0RHS+EmofJjXZZg4KhpDzv39lNsCKCR6WgMQY7dwjeUKlMBKbLSGUMmHMdgylZM0ac5pVsta7ktGY6XXPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696898; c=relaxed/simple;
	bh=XL1AWfcMQuED3+hDWDsSpEEuJM1Io7EQabdRQPEMT7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2dsLV9+hn15ow9GgFBP/1tXCqTRcgAdxQphWyl5VLR5Yts7MiVtkMLDdm2qLY7Sji9D6KGysKcU49lBPv4WrajWQH5lrNM4+uVaknnIbc7VI8uOMh9fd2fg9RvnFCKhOOauHNuZY7w7SQOLjiV7X+BVtOCnOz7CJ0ba2Q923R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zw5tyvyh; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zw5tyvyh"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a71ef98bc4so5405ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731696896; x=1732301696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mv9th6RLPlcLuYyF8YF/szfWWY237bnEw0JOc+w2rs=;
        b=zw5tyvyhzw9dvHlFvd52/ah0dpvZjelRvF6xKYLl1r4oRUjYfqKKNo+9EsSUMbJAXk
         AVZ+fT5Zt7ABLuAK+QsfKIdwmtYnv5UtMW5+mM5LGj+VFQo2sq6FWLncl6vxzXXFa0/d
         zkfoIlplQ1a5HvYaZ7GI0Yi4/BoejzPdiX+Q2T/J5d4xdblc9aBGvV1zQsFbc4JDSMH2
         Cox6EJliwpLPeEqAqeR4HnHtesbxRU9BtjqiICO71xPjMfyt9wjaeH/mICNXE2vl8Hhd
         9n7S1Y9woMJeRTRctx25o/0WWMGorOFaG9s+RfQ1ec6RYWOJeeyw7yUcnxbTRb1ZmP4d
         Lr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731696896; x=1732301696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mv9th6RLPlcLuYyF8YF/szfWWY237bnEw0JOc+w2rs=;
        b=hgn1GKAALaI52ASMFd5c+poWU+zvYB3ji2va8KzGiHN5sBYnzH2/jJq2/HOLIUi5uP
         K/B9hq2BMVHWjHuasTWyNLB8V3h0TB08k3Z6CrQxSA/1zlzRjoxtkK+tBebHWXjX63s8
         x+Q9NkVWWwT0tlwpuatlMWvTF2e6WxUpssLd/cc5HnUVlmzwrmxgKx6b965cFV4f0Sqo
         7ekdtj7LNGXskl1VMdtTfnhCR3iSvh20RuSHeJqdeTQHYH1kSg+ktV0teIF/Ud0VIP/7
         //qe2fs46CiFh3MIis9Kgae9jfpLPy2eQ6rCp+l9rqDNFzO8uRD0e1eVN28SOTRj+2Dq
         N58A==
X-Gm-Message-State: AOJu0YwWQnGzkCE7XFdyA0rnFhgp6GEZSjvVRN+vswW3dVq/424FLOpW
	Cpy8HAGn6xcFkEe6KG2ZZk9nmvoAFyqMdT7r9o3MErC+rauNolKSrzwb/7m7py5N/RWebuKx40x
	PpngdgdcymovwGDr7v5IUu/xraMixZjnn/PtM
X-Gm-Gg: ASbGncsdGJsB23H4KoXZtFjAzebP5++jV5rDaxYzy4NWiIuk+VMT2wJcpSeXhJqP0GN
	0x7qnb69i+stIrlC5uEnVJfJ/GFMSE5B4
X-Google-Smtp-Source: AGHT+IGskty96hYt6pZIJKjsC89dnllav5iSiNZQkX/KQ+aDZq8J5yklDjWab8uM/9blry/8JHog/Y7FGg4pre1SE6c=
X-Received: by 2002:a05:6e02:190a:b0:3a7:28e3:268e with SMTP id
 e9e14a558f8ab-3a750c3bec4mr66855ab.12.1731696895851; Fri, 15 Nov 2024
 10:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115161600.228994-1-james.clark@linaro.org>
In-Reply-To: <20241115161600.228994-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 Nov 2024 10:54:43 -0800
Message-ID: <CAP-5=fUq1JLCVLQerQbK+itNg2RZaP9zCo9RUTgKoGqTQi3yYQ@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Make leader sampling test work without branch event
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 8:16=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Arm a57 only has speculative branch events so this test fails there. The
> test doesn't depend on branch instructions so change it to instructions
> which is pretty much guaranteed to be everywhere. The
> test_branch_counter() test above already tests for the existence of the
> branches event and skips if its not present.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 85d512f5a126..0fc7a909ae9b 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -231,7 +231,8 @@ test_cgroup() {
>
>  test_leader_sampling() {
>    echo "Basic leader sampling test"
> -  if ! perf record -o "${perfdata}" -e "{branches,branches}:Su" perf tes=
t -w brstack 2> /dev/null
> +  if ! perf record -o "${perfdata}" -e "{instructions,instructions}:Su" =
-- \
> +    perf test -w brstack 2> /dev/null
>    then
>      echo "Leader sampling [Failed record]"
>      err=3D1
> @@ -241,16 +242,16 @@ test_leader_sampling() {
>    perf script -i "${perfdata}" > $script_output
>    while IFS=3D read -r line
>    do
> -    # Check if the two branches counts are equal in each record
> -    branches=3D$(echo $line | awk '{for(i=3D1;i<=3DNF;i++) if($i=3D=3D"b=
ranches:") print $(i-1)}')
> -    if [ $(($index%2)) -ne 0 ] && [ ${branches}x !=3D ${prev_branches}x =
]
> +    # Check if the two instruction counts are equal in each record
> +    instructions=3D$(echo $line | awk '{for(i=3D1;i<=3DNF;i++) if($i=3D=
=3D"instructions:") print $(i-1)}')
> +    if [ $(($index%2)) -ne 0 ] && [ ${instructions}x !=3D ${prev_instruc=
tions}x ]
>      then
> -      echo "Leader sampling [Failed inconsistent branches count]"
> +      echo "Leader sampling [Failed inconsistent instructions count]"
>        err=3D1
>        return
>      fi
>      index=3D$(($index+1))
> -    prev_branches=3D$branches
> +    prev_instructions=3D$instructions
>    done < $script_output
>    echo "Basic leader sampling test [Success]"
>  }
> --
> 2.34.1
>
