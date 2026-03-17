Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A212B94
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763756; cv=pass; b=tN93IPXShv+BwD7UTrIJ4G1HgU5bw1lRNQBTWO0P2eQ5ZO90roxasNK5OYzKn4E6pePCY1zvMI2ISmsjlsVMC013PSGCQhfIxxVpuh3k2aSg7LCSLHVqMahHoFT1hBJHiCs0NUNooSVrDFCH/E4qJ4e47ZEa/NnppYnycxCPo64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763756; c=relaxed/simple;
	bh=/ZF9UP4yibE7xa6Yhr4iI4Um99FUDAumWUABin92L3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tByzKUBjDH8DA2h9QeWD+lM1XR9UprHApUz9h5YYV8zVh3ubzXcaklOg9cy690I668xdtAvijeGjXbkWn5fUsXXB17HzqqY/dzpP/ufWZYb2mg5vIlQMsRL4PvCyxNcJqirOYTzteMO6yuUlw+eH2hgVM7s/sb20yWXfJrLe1F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvhxfYhw; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvhxfYhw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so96275ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 09:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773763755; cv=none;
        d=google.com; s=arc-20240605;
        b=bMcSsfP4BfUh1nT02byl+o6AfppQ8R9XydBAtvnsa+QxZlobrLqNn+YBCGypWZanYu
         aOda690i/TUGwoJSdW0GlY4MKm8UxdF+8+zbBjUg+Y1xEm2DSC3oCBQFXZ9SVTFz4x7s
         uY3dOx/5vXUI7dCOrT3PKRIr7rYTg1jVJg0SFiAc/UWgZRC7yU3GpCE/x3/GZE7tNP/S
         n+XlPGT4iMSQypggJ/X0pbV7tO0lHJ8c0+8trLyRqQintJXcRx8lcXeewltTh6UT6Rc7
         wVVTb3gaynr/A88h5Bjl2zOHYFYembMWKKa4ObgA6VRR4w07svE45B1Wa2Mq1M4ezDIO
         6wdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TwZHlgO1CKayfhFJ9zN5osc6AEr+794S0iYzUhNA7a8=;
        fh=9YDFB2QY0xL5P77ZHIUMrqkG3qUPYCj+lhpxtOyuL/s=;
        b=hlLUg7Tfpa7wCtcrCL6AgJoQ1X1dAKdn6Y5vmjuyTx9HhMYp878RFjjQeIkibJH6dX
         LjECTzpUXWuRHa4KqeuP4beohanRXBI3hgruhkTDT3kh9w5QP7EkLN06mfekex0JqoFY
         iTuCe6YwtMybnUFn1Oxop9UbtIjFIrNIrev7fhTXtUZjqpKzK9oYWgLxf72fOWI0Y25N
         EcwAI75D5KNVefqgrMsmQAjrvPQrToFFZGx5WaHQ8oDKy8+zCgbNKS4AH2jJLeG+8tMU
         o7ZAEMmRZkxndQdfn0GoaHUf7OhLFIJrwsZTvF2wzz+PBimWSb3cD4mSPZVUdba69ZN6
         Z1Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773763755; x=1774368555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwZHlgO1CKayfhFJ9zN5osc6AEr+794S0iYzUhNA7a8=;
        b=cvhxfYhwTXChdPSPWROaJSrb9nkY9pQ2nSHcNAhx5s3HAvOno6MIWLCJBQSV4dZ6H8
         Cpx7ovM6aFIRLaPzR4apz+Jw3DmOtQYhvwsDy9H8ch1I6G7trSKT7PRUDg3BmigYzm9O
         RV5OQljoND7qR4tmoBH33HOHh63rGDXQd7aVe6KQiN4vjinxu8FQptUh93f/t03bBAd2
         Biu9Mi/2VhSZrchPC7EvXhJuBIBg7S/+u0gvl4Yh1e25s/VRygSQu8+PgX+Urrtg0hVd
         v4ISPYUOdGAHrkhrKTh/faKRAvuduygaNjHDxliU/o4o9jBZ5JE3eyRXUR8abr8kNuTJ
         jbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763755; x=1774368555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwZHlgO1CKayfhFJ9zN5osc6AEr+794S0iYzUhNA7a8=;
        b=NakhPIkwBX5rwi9cKq/9vkGnxJy0wOMaGCIRrxb7ze29zVWguRKi9G1POYnbyKxEdA
         Gv9m1wwSBwjTv2vX2Riqv8yZqGoYIazxx9g3Ln7/z3QVA4OQagBdW42mnNsn2OvqAQr1
         FBL+ytiOKxErhLzXXOvgpqyJkYNJvIY3CJvLXHQcj+sy+mqz/M+I73p/SNYzT66sXk7p
         Yhew88FXiBzGMIOIrtH30B/ofZvsn9F64h/FKJ+amsHQYEBkAd9wTfwpQat47TazXS2Q
         vhw/OyB5u9mD7PEUMfiyEyPDMfonbw/RUq6Jj9bq2kH0SFAlLAH7lb8aMEyIJ78zO1Aq
         CEiw==
X-Forwarded-Encrypted: i=1; AJvYcCViwKAps/PpPPmZwqO5dvykVbAhn4/NnI8M8YeC4S211mVMx9E5hCMPunIExVpLSjcPfU2smv+0P7XdT9YliZAt@vger.kernel.org
X-Gm-Message-State: AOJu0YxxUXbbaEweWBI1RJlkVHmuCntPaY0qmlZWQMII5QbDV618n7m2
	QaxcF9Z55UKfEJF8UCNrGt+JZ1WVORwtvjqfMVHoSUe2r/grTV9LiqCwfzaFGE+phRQAb3FcGDZ
	sJgCjebSCt+bBdo4LJaE5rLKJn7pMwR2T+ynTHSU8
X-Gm-Gg: ATEYQzxjJ/vXTtUxaJK/JQ85KisyLOnMa68KxkIbfDX2ynFsDw91ZfPf6TPt8d2s5b8
	n6Gsnv0AF8TNzqdpt+0O/Srt1qXjrLD7GD2O/7Dn/fID+ZzJn25pMiUnspn5K6QP3Q10pZhKS04
	1rB8kfgpkOGOk7vEEff60wWpnk+nj5TZ+T0yZhh7h5h/98RaQP5OY9y2498WzXAK49urcqoOjsf
	F8n7l1v9u/uchqbR+CF1QyqapXAwXnxWK/5j3bd8Y/U3FOuDRkVgy5oR4psAi5O0CtKIp20QwX0
	lt/Dsgc9LFQP/+jltUg=
X-Received: by 2002:a17:903:b8e:b0:2ae:5d57:c94f with SMTP id
 d9443c01a7336-2b06402f708mr3429925ad.16.1773763754307; Tue, 17 Mar 2026
 09:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314083304.75321-1-atrajeev@linux.ibm.com> <7D255F44-3588-460F-ACFB-6ABAEBA152DC@linux.ibm.com>
In-Reply-To: <7D255F44-3588-460F-ACFB-6ABAEBA152DC@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 09:09:03 -0700
X-Gm-Features: AaiRm53nq8oPXRj0zgp85S66JPVlj4x0AFZ4dunl72riUQ7loIf52pJrwRVofrk
Message-ID: <CAP-5=fVcWpBTALH1zr7dL3qH9j24c3t3L0zvExaWbnC-2tXjcg@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix the check for parameterized field in
 event term
To: Venkat <venkat88@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, maddy@linux.ibm.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, 
	Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 1:56=E2=80=AFAM Venkat <venkat88@linux.ibm.com> wro=
te:
>
> > On 14 Mar 2026, at 2:03=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
> >
> > The format_alias() function in util/pmu.c has a check to
> > detect whether the event has parameterized field ( =3D? ).
> > The string alias->terms contains the event and if the event
> > has user configurable parameter, there will be presence of
> > sub string "=3D?" in the alias->terms.
> >
> > Snippet of code:
> >
> >  /* Paramemterized events have the parameters shown. */
> >        if (strstr(alias->terms, "=3D?")) {
> >                /* No parameters. */
> >                snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->n=
ame, alias->name);
> >
> > if "strstr" contains the substring, it returns a pointer
> > and hence enters the above check which is not the expected
> > check. And hence "perf list" doesn't have the parameterized
> > fields in the result.
> >
> > Fix this check to use:
> >
> > if (!strstr(alias->terms, "=3D?")) {
> >
> > With this change, perf list shows the events correctly with
> > the strings showing parameters.
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Thanks Athira, Sashiko is noting in its review:
https://sashiko.dev/#/patchset/20260314083304.75321-1-atrajeev%40linux.ibm.=
com

By inverting this check, parameterized events now proceed to
parse_events_terms() and the rest of format_alias().

If a parameterized event uses a built-in perf keyword for its parameter nam=
e
(e.g., config=3D?), the lexer parses it as a predefined term token, which s=
ets
term->config to NULL.

Does this cause a NULL pointer dereference in the term iteration loop?

list_for_each_entry(term, &terms.terms, list) {
  if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
    used +=3D snprintf(buf + used, sub_non_neg(len, used),
      ",%s=3D%s", term->config,
      term->val.str);
}

Passing a NULL pointer to the %s format specifier for term->config might
cause a segmentation fault or formatting corruption.

Can this also lead to a stack buffer overflow due to how snprintf() return
values are accumulated?

snprintf() returns the number of characters that would have been written.
If the event names and terms are long enough, the "used" variable can excee=
d
"len" (which is typically 1024 bytes).

When evaluating "buf + used" in the same loop:

  used +=3D snprintf(buf + used, sub_non_neg(len, used), ...);

If "used" exceeds 1024, this creates an out-of-bounds pointer. Modern
compilers can use this undefined behavior to infer that "used" <=3D 1024
must be true, which optimizes out the safety check inside sub_non_neg():

static int sub_non_neg(int a, int b)
{
  if (b > a)
    return 0;
  return a - b;
}

The compiler can reduce this to simply "a - b" (or "len - used").
If "used" is actually greater than 1024, "len - used" evaluates to a
negative integer. This negative value is implicitly cast to size_t for
snprintf(), resulting in a massive size limit.

Would this cause snprintf() to write past the end of the stack buffer
without bounds checking? Using scnprintf() might prevent "used" from
exceeding "len".

Thanks,
Ian

> > ---
> > tools/perf/util/pmu.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 23337d2fa281..0b8d58543f17 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, con=
st struct perf_pmu *pmu,
> >   skip_duplicate_pmus);
> >
> > /* Paramemterized events have the parameters shown. */
> > - if (strstr(alias->terms, "=3D?")) {
> > + if (!strstr(alias->terms, "=3D?")) {
> > /* No parameters. */
> > snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->nam=
e);
> > return buf;
> > --
> > 2.47.3
> >
>
> Tested this patch, and its working as expected.
>
> Before Patch:
>
> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
>   hv_24x7/CPM_EXT_INT_OS/                            [Kernel PMU event]
>
> After Patch:
>
> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
>  hv_24x7/CPM_EXT_INT_OS,domain=3D?,core=3D?/ [Kernel PMU event]
>
>
> ./perf stat -e hv_24x7/PM_PAU_CYC,chip=3D0/
>
>
>  Performance counter stats for 'system wide':
>
>         2018866563      hv_24x7/PM_PAU_CYC,chip=3D0/
>
>      229.938231314 seconds time elapsed
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
> Regards,
> Venkat.
>
>
