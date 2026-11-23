Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459467;
	b=n1jWDyqiZOUwVb7Wj1jcWO2ZiMI9hxH2ahk8ioQKabbIwuh0DXK45Au0Db0+6XyjxN8J
	 RP8ADMIRfO/jaWQPmg9EsQXLfCGSf+Gd5dHdXYdGVeBe+59xKQZtUjE6ggF/wHStGcXEa
	 AHvuZ1y3e+O8hV8II+RUvL4R5KcXCy5exmcueHpCbSSq72E3neYvcqF0bpQkxXspgItvX
	 EAjHUwpUIzMnVR765/NnrNQLVA6n7W2Y110j8gYYeb9irtfjXlRb2HVF/NY5YZnOD/EIK
	 fo6/8SxlZcvEwnrrR23MbO+pzF+dQsOe8Jc8U6zIYAyiBEtZPO6W62DP8Z7ot8dM96g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Qpy9q3tA9qQtSLTg1mBMWXjE/nQplNi9tWL6pr4AjbI=;
	b=NTnyQhmMmYSxNBg5nyvsyQNHVdaNdWH2pbSmNXby6zmLWbNCdKHaCEElWGMSNUAiZrNp
	 I99ZM7NtgpDhXuIrUQyolrTfgP5Q9tmXW0LajikuERtrrkAkvAllA2kleoQSO8CefxAm7
	 eut1mRVNPPLl88R+fCjeNeuszh2F5XAzVWwfHd7XtwMfNqvBIhINOLiZ4psIhxWHxWmnI
	 7kJyap2IX8CX0cJyC7j9a8AET6SwnxyQdybmFCCx5hf6jL2Pe9tbl2X7BgNfDSESLm1cx
	 BY6OzIAbFuE2SfG8qcLMxWm4wfQCbjtnTicWk6pNeV6Fjs0u/6+WxkSnwwcg1hh7cUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="IT5JsX/d";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1336606A69B
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 18:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1336606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IT5JsX/d
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-533202fe429so590731cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 10:44:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795459466; cv=none;
        d=google.com; s=arc-20260327;
        b=eFWKwt0DYM0CzIKOnIa7xEFw6GxStLFC8csbp1mow9I+MNo8ZyXmNIYNK2nrl1cos8
         uu5wOtjNpOgMlfyHm+oCxrXGvvk9203Bt5JWPBbxETPl8ZwtS1MuqR6pw402qyQ5YvOg
         gSHQqwaAVsdH7bmY65deZc/EB9bDl5DNftb4iW+I8RRgoj1xSBYPnwkiDgC7tD5DzI/W
         HjqwAeAlF3AOPhR7v3qtuH3wcJ18gw03eZIERlFwJT0zJiEgqzWjvc47g1TF53Aa07TA
         /7koYCiC5M6dw/yo49oOO3lfMubGWSurxpr2/ra8k7ZHIUT3iq0j4GbdhCXDGorJqOfi
         rn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qpy9q3tA9qQtSLTg1mBMWXjE/nQplNi9tWL6pr4AjbI=;
        fh=8lt7cQvz2xbW61DP8b2SVJISdKDNr1rh1T3ORYCQX5I=;
        b=PO1Nn2DCipEICw//5uIbNcq6Jy2gAlqYTFZ8ZfIUckNePiER/UUBzfWyOwRpOMpyCj
         ugG4Il/aoK0vpMMXy+KNq2rd0n4ETTLzcolYtWhTaoKjJ6C2PXTaS+I6j1SM2vRIr/0N
         3qxHy8EDUHcoXXCPGLXLNZziKaKA45ynU3u94UXzzhegQBK0nq7za956pM/CIMgrDYwu
         4o3dauulUql6JXYKo90fRVL2KMacDZ5fVbd99VWd9I7QO3HCjwBQt0cxvBOmrnm+3bbb
         PtYKKRcCD7YhVASKONo5YiSUAjJlQ/PwDBoJNvZheGAZyemYnosBcVnK+krMkx29mMeo
         eBhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795459466; x=1796064266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qpy9q3tA9qQtSLTg1mBMWXjE/nQplNi9tWL6pr4AjbI=;
        b=IT5JsX/dtjOhmY9E/JG/x89RsilUFdKcK1wywxQLw0TFNzHPUuuGDilgqzyY6G/RJj
         tWXE/l/tpsOcHGScQSh3t34esQf5ZhMHQ3DRaox9hGo+os1FwebSyw+6zXg55Q6q32X9
         XyupyygjD6ha8TYu3qioTgsLYrcYLTmIDoF621+7FzTOX6WFcW9WDj9bETKNfEo895Hi
         FdJPOIOKyYLHui61RW+dglVJX+1Kxm6u2Ck3DHOdhHrtOAdZoNabB/p4k7mNObJH3hz7
         4yvmlu4UX8vVnQNzzOFkScUhdO9yv+E3fBhcqAX1Yf5uacAHMmAytP/houVeVqchPuvj
         ceXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795459466; x=1796064266;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qpy9q3tA9qQtSLTg1mBMWXjE/nQplNi9tWL6pr4AjbI=;
        b=qZ9er8MK/Altr0/Cn/4P1u4sekGIcjApuZQJv4XS7jCGBJyd5vqydcLDv0P1rC8S21
         YJezhQiFiV5pWfRcUGHTeSSq5ym9G+5/TxUgmNaowO1zN4mqD8XF4vdCY8j+CuYRHyom
         dIJtojeBVGLAXUnqRFCQ307c3U7rEfT24LJHLKkOeMBzalIXJ9W+10nN+2w4dg8utB5q
         sGqhZnSXUUp2EB2+1KbBS8Tgh3fP1Z8t4rYmhjatU+Q4N8Q7+2jtoBOCeyEUL0z2gUVS
         yk079Bthsw601DxmQFEh75+ENbqjSlPRGuFOVQ2aDWVWkLoWFTNWTsIJ7PV9npV8GYq+
         MUjw==
X-Forwarded-Encrypted: i=1; AL+hErGLe6p+Bvx8IRr9Eh4Z2JnrCk6ld3jlGaupil56JG0FI19MeqHHDJ+tFuYV374gm7TurIZYawJB4vVQddJNdJgB@vger.kernel.org
X-Gm-Message-State: APuU4Z8l1VWyBCtbY5sYnVLYhMH6JIlUFVp3QKUrtyZTv9fMVovtdWJ+
	mfQfeIG3kNPDXMkwCjNlUfSx8EYDCDYHpyS6+JEjp2puf4IKoiblkWRR88TAtXffx4yYfdekbmN
	fe6HSwN+TZH0FcKQKuq1B2PyCwS4Nv+Q+1qTQZSAq
X-Gm-Gg: AZFdTZeUKwjbWT+hd5NqxRSSK+Cl7Wr/PF84IU96+8cDUPRrMm1hjaolO9U+/phmKaB
	PLJLnXlchhibdHHzsHesaFzS2BwUziSasw4gYhWnF6cBp3qPCpMXpNwWsGJ7J5YmD1ArVMAGcDj
	yCB4mu7C+uMGuc5uyjee+XqQ3U0RXal08ciuuzEr4N09iwUHYynFQliTajgua4O0wqj9Wc6yGyy
	qz8/osthUDeXSwf6v3D3Cev4VzUo7+t/ZLee684dhFzIyuEEyUnxOda2JDKNpW0Fq/1JFXbzNiq
	pM5DY52H9LJg7EcUNGH/K/EEoeq4Zmo8nbvtp0OCvh7nA01cz9qD09k8Y9ySeUhrNv0AWnSGk9j
	0xY3X3LR09al90QlkYwJ6cq1Z/zvDlrrv5qwy
X-Received: by 2002:a05:622a:2598:b0:533:9731:f0f1 with SMTP id
 d75a77b69052e-55d890363c8mr39729921cf.10.1795459464949; Mon, 23 Nov 2026
 10:44:24 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org>
In-Reply-To: <20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Nov 2026 10:44:12 -0800
X-Gm-Features: Aa3M54p16W7pU3nt1aynmNQ3smtylrp8OV-U9T0DYy6BSjG3aVS2eWBmNAGg92s
Message-ID: <CAP-5=fXuQWTt1F6BvKSXqgSkEtBQPKvKg6gmAe-ngyr4VGyGig@mail.gmail.com>
Subject: Re: [PATCH] perf build: Only enable context analysis with Clang 23 or later
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 8:46=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Context analysis requires Clang 23 or later (see
> Documentation/dev-tools/context-analysis.rst), otherwise the build fails
> on older versions, e.g. Clang 18:
>
>   util/env.h:142:39: error: use of undeclared identifier 'lock'
>     142 |    struct rb_root          infos __guarded_by(&lock);
>
> Only enable it when the Clang version is supported. Leave the other
> thread safety options enabled if they exist because they don't cause
> build failures at the moment, and might provide benefits even without
> -DWARN_CONTEXT_ANALYSIS.

So we've had -Wthread-safety for a long time in the perf tree, I'm
guessing __guarded_by is missing on older clang versions. Can we just
stub out the __guarded_by for these old clang versions and keep the
lock checking?

Thanks,
Ian

> Fixes: 321967859933 ("perf build: Enable context analysis and Clang threa=
d-safety flags")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Assisted by Claude Opus 5.5
> ---
>  tools/perf/Makefile.config | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index aed2e952c8f3..f5adceee5589 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -65,11 +65,15 @@ ifeq ($(CC_NO_CLANG), 0)
>      CXX :=3D $(CXX) $(CLANG_FLAGS) -fintegrated-as
>    endif
>
> -  # Enable context analysis (linux/compiler-context-analysis.h gates its=
 Clang
> -  # attributes behind WARN_CONTEXT_ANALYSIS) and Clang thread-safety che=
cks.
> -  CFLAGS +=3D -DWARN_CONTEXT_ANALYSIS -Wthread-safety
> +  CFLAGS +=3D -Wthread-safety
>    CFLAGS +=3D $(call cc-option,-Wthread-safety-pointer -Wthread-safety-b=
eta)
> -  CFLAGS +=3D $(call cc-option,-fexperimental-late-parse-attributes)
> +
> +  # Enable context analysis (linux/compiler-context-analysis.h gates its=
 Clang
> +  # attributes behind WARN_CONTEXT_ANALYSIS). Requires Clang 23 or later=
.
> +  CLANG_MAJOR :=3D $(shell echo __clang_major__ | $(CC) -E -P -x c - 2>/=
dev/null)
> +  ifeq ($(shell test "$(CLANG_MAJOR)" -ge 23 2>/dev/null && echo y),y)
> +    CFLAGS +=3D -DWARN_CONTEXT_ANALYSIS -fexperimental-late-parse-attrib=
utes
> +  endif
>  endif
>
>  include $(srctree)/tools/scripts/Makefile.arch
>
> ---
> base-commit: eb79d2fbc230d41b009e49f20671303c6efbd946
> change-id: 20261123-james-perf-late-parse-attr-4e996381859f
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
