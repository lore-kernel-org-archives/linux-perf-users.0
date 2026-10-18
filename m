Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D070A4CE692
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336202; cv=pass; b=HjpJ9+d1lRb3mk/89+VtVDkWo7YwmBBZulMrg1scZLyEIUY+plFcoh5XZifOpSfLydO0NQwxRT7kXr/B5ja1Hb3XmLt49mG/gUSPMAT3NZTzSeXcrBw7MPtXNfnIxqjD7ocHEc0QqMSMafCYnejt5v6VvUqBb8VWFUOupuyJgPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336202; c=relaxed/simple;
	bh=N4MLccwfKEkqasxhVR0gl/ulWEu3X5rYO9+B9Hx6Na8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNGyXThSF1ueK0pWDFC3V99grXNq6rHoVerCVqtExoZzkiUBBd4lT0g2b0Ov/8K4VUJ1p1NyoJSekigJnUBwt7af1cmToitjzx6YMG5S01tohcXmFaDISIxFsIX+haSxaa6BLgzYE6rtq/VrCXeWYR6DacLgdydKUnv8nz4AUdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=REPnpKCo; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="REPnpKCo"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-679a2297c55so914966d50.1
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 08:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792336198; cv=none;
        d=google.com; s=arc-20260327;
        b=Ay2d3ehWXBa1bYTXV6PdnpzyUbgVYcl1NDmccglghy4BFhbS6t1nJcOS4Tun3tai9j
         fRiiefGdgp5NW74+40Mwojh/SBHhUy14snJoayKBdqtnqQCov8Xa+1YXA9My4F0hNfDG
         IsYaDwLDe8qZhuB4+zRGXsOgawgWgBKWWSZFcvOuwP1p04ZAj+WqbeCFZAmoV+dfLqj+
         PD6/pEfVmngFvL1dwOva7Gv+zurSJU52/PpOgydBOdH+MWMqd4S7Yplvv3BQhc0Z3O6h
         GpRkNPFH1MKqJmNqr67IWKRZO8nkXXPN5Gdl2n2G5aVAHNpGiwvu1yFdx4UqLQz14Nvp
         Jjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=78LOVU45e6uFHgCeferQiR25aeZzXMlj/EwH6Nuj4RM=;
        fh=nVU7mnRu5x7QJlWUI+yl9Z3A1qSY+Q02+j5zOIeoLa0=;
        b=bsi0Uv7Pdb4W5IQicubhi/hIjz9iT4n1Vh2ixtzjPxtiKmi6doaZoGGr9bD92ijqN5
         Spsk0YJ0gpTprCAMMk9gKajaVnp1nWKPJO4dlpkx7Olv0OGsiM648BwgZV4w8U5BhVHq
         9C0j1nqicbjKOta/mQXW4SUAOQrsh6XVqemTHBRvgYVn1I25c70vxx5CL+OlyCCGzCQ/
         6IYDUGuPZGzlK50+L2PDApTeTZ3HYqKxYGH/OwPulbAumutvSRUpuE6HZ/jPLczDU+KI
         h/CSplHWmDIstLZYlhEKQKyL7ZWZ/vUq9oZL1/xXbu/ytYmtggW0EIJ9s32LX7bnmUJV
         JAiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1792336198; x=1792940998; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78LOVU45e6uFHgCeferQiR25aeZzXMlj/EwH6Nuj4RM=;
        b=REPnpKConvp5EguDt628j6QkM9e8MOuot41RTBZswlxGdKmqUsKM2OdagKFHtDzTpT
         +8YyQmIbaSt46+x7UsDtIzM8DYyXggvIyruUfZixfP1WcEsq+H25O3xoH6W3wEnSHZWT
         dpllzvfhTvofY+WIcTPqQe4bLtmLFZiYDthr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336198; x=1792940998;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=78LOVU45e6uFHgCeferQiR25aeZzXMlj/EwH6Nuj4RM=;
        b=KzdjtaPYtEvd3fQWGpLrvoPQFQuTlKb2mzKgrrYwEuaHE0eelW5Oxde7LEoWXrp99R
         ihVq9eC4NfChv1qcUmhb63It23E4K+uT6Rs/SZhJMi1F1RVan4TKVluuDPd6vHPVOHWA
         2Vu8Fg1t+BVBYnRv1vieke6iQhHinq8DCz7kofyWuCqrFer1wYdkEGH5eXC951aMSHLX
         ZT0gEWa67t+fYBibCLYIpxC02l/gipS+Vf3KNItFnLnoSjocvLo0F6GzHRBoHj2mxASu
         jxTs5nNevKbVW+GmHRUmpOXKUHfkw5j/Fjzb39ozbkB27dvdO+uShp8LkRUiOUt09nRG
         wOzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEm+ewXGBXLULysmlCKFwsYo0rc0UFT9gc+8lcNj7Idrg2adm+t8nKNFtenWWWQE9356/evMy9NMrb/AlNgaKf@vger.kernel.org
X-Gm-Message-State: AFq9FYJD2yU/2bkINuWZIfWc/vfiuqCAlAlgjN67pqN/ICJhqXdC7Ufp
	YkWjmv7pjBA9reFd+86MZ+LD91q2OJ8hDJTcMxJDdj4tCZl2795JVAh+W9RNQYrprmwux2muFyW
	Q9QFvDoi6yVRI6eDuXOjXcBf6YKZrmZvAGf7ZFSYkrw==
X-Gm-Gg: AYBFou0tPYVDWo6invlsylz8oTjMtzni2/by6m8/4Pqyv5JSwtzGKNo1ba7mwB1Pyt1
	QVBHiZo9mKuPm422uzD+j2fATaeQ0ejMSVNqlJ7LSbIgjaacuhANo0UfD3VPcfBpOqbCgENJnmj
	QHZUI6vambRbL1sH+2NGqE+yJugdyC1r1jFfdA8BVMGN6b3UmtJJA665OVzrXB1WacK8bdWbSub
	RmGP7EIXkfWsUpVQX1RBkd8v2/bOPGmVbXvjAbjvB0LvSivZmbqZ0PHdYFh1eKT/lKXNC5cRRVW
	Gmffmq+y/JjuviIxigIdDyHMWE9Qjp6lfnJ3dzbk+mcam07xi3UNFE5HjjbuXCvVmSa6r9RAN5X
	/CrbsLu6qWaw=
X-Received: by 2002:a05:690e:4146:b0:674:d78:4bd with SMTP id
 956f58d0204a3-679ca4d55bcmr1937276d50.5.1792336198350; Sun, 18 Oct 2026
 08:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
 <20261005-perf-symbol-memory-send-v5-2-165dceb2b049@uber.com> <asbDJrY97tRqoPaR@google.com>
In-Reply-To: <asbDJrY97tRqoPaR@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Sun, 18 Oct 2026 08:09:41 -0700
X-Gm-Features: AclHuK-9HhlC5CMbxjwMvm0ouY6drD8ZrPCJ85CHJwhmt2IH4AP8QVPhCriTDZk
Message-ID: <CA+w=M=TtAfiHVQqiwmchtsWwNeN5So5MxWW=82RRAUXHhg8D+A@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] perf dso: Allow reading DSO data from an explicit file
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Namhyung,

Sorry for the late reply, and thank you for the clarification.

On Wed, Oct 7, 2026 at 3:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> I'm afraid it may confuse perf annotate where it needs to read binary
> data from a file as well as lazy-load symbols from another.  I'm working
> on cleaning up the relevant code and I'm reluctant to add 'path' to the
> dso.  We have too many names for a DSO already. :)
>
> For a short term solution, I'm afraid you need to use dso__get_filename()
> with symtab_type and read the file without using the data cache API.

I understand the concern about storing this path in the DSO. Perf
annotate and the lazy loader can read different files. I will drop this
patch in the next revision (v6).

For context, the v1 lazy loader kept one file descriptor open for each
DSO. In your v1 review, you asked me to use dso__data_read_offset().
This let the data cache control the open descriptors and close them
when necessary.

Using dso__data_read_offset() also showed a problem with split
debuginfo. The symbol name offsets refer to the symbol table file.
However, the data cache opens the runtime binary. The same offset in
these two files can contain different data. That is why I needed to
tell the data cache to open the symbol table file.

I put this support in a separate patch after your v2 review requested
that I split the exact-path DSO data-cache support into an independent
split-debuginfo fix.

For v6 revision, the lazy loader will call dso__get_filename() with the symtab
type. It will open the returned file, read the names with pread(), and
close the file. Thus, it will not keep one descriptor open for each
DSO. It will also not change the existing data cache.

This short-term solution can open the same file many times. It also
cannot use one DSO cache entry for nearby names. However, later reads
can usually use data that is still in the kernel page cache and avoid
storage I/O. Therefore, the main additional costs are the open, close,
and pread system calls.

The performance cost is small in the test profile. Eager loading takes
3.2 seconds. v5 lazy loading takes 1.4 seconds. v6 lazy loading takes
1.5 seconds. All three produce identical output.

> In the long term, I think it needs to pass a binary type arguments to
> read data from the dso.  It'd clarify what users want to read and
> support different files at the same time.

Ack. Your recent cleanup keeps the binary type separate from the symtab
type during symbol loading. The DSO also has a separate debug-info type.
These fields identify the files that a caller wants to read. The data
cache does not use this information yet.

Unless you are already working on this part, I can send a separate
series to make the data cache type-aware. The series will add a type
argument to the read API and keep separate cache state for each backing
file. I can then change the lazy loader to use the data cache again. I
will keep this work separate from the lazy loader patch series.

Thanks,
Alireza
