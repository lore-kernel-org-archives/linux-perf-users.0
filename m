Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0214F70
	for <linux-perf-users@vger.kernel.org>; Sun, 29 Mar 2026 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801139; cv=none; b=IWLPHl+zvgNfdAiPM8yt7bhh4bwLTF68us0/UKZAdBXWE/AqdKQyMr4CfZuoKY0DLdrflk/xjF2wu6/FxWtiAczXsPz/RosAfkw17YmEnjJ8dH3juZlpNWZVpkwpTvBstEkgyGAl1bDnowZ4cELyUIeiejYmkGpA/+yZynM8Xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801139; c=relaxed/simple;
	bh=DDR7/biQEivv2qc3sw/5wMa3uZ0Vf/JSwjwbNIat75Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0Sorq4SOejNk4aYb3BuVH4gNipJTCKG6rH5mXlUuN+kKi4bOEIa9tDRbiR9p3XHVPWtMNEZ01lp1jWtw8HpW9XFeyogQrrYAwmkbncCWYfwiKSdBUoVY5iQQGctUGssD1RJLyEtv0GUY+fTgb/jCXlfVCnEpQcKAe3h/1TZAmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ5V2HTj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ5V2HTj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66beb21f3ffso394299a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Mar 2026 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774801136; x=1775405936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5I3lcqeRKGWbcd+bgTXszKr0+49iSlVC1ea8hfMMr1o=;
        b=FZ5V2HTjoAKAxshy/rJUldruzsqFZnYIlKxi6A/5iZ4mNXn15pLdnM9SZvAmCYZB80
         y5Bkeph7Kd6tIBCJbnWDILJtZ8ukXHpUn9WZx9LclBSzXO8bwLvhKXAyXC3pBJlXfRkC
         lXiNHj4c/DnIHb6heOCpAfn9GGhDmtMxD33xWJVqgZDUr26a/st2ibTGoBCzl2OalNkW
         TQTFRU7ze8aDx0ItHAMrWEe2tBA/ED4yV0vTwFDyu5XBZBuelfsg6EY8W32RRwhAIO0D
         jtuc3Gf1w+jGCDSN0AVOAnwgML4sO7N8C3eAPLmn+zQXHAb78kwnrim6chvCZjv6ob8s
         wG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801136; x=1775405936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5I3lcqeRKGWbcd+bgTXszKr0+49iSlVC1ea8hfMMr1o=;
        b=hFUi5+v62JmzQSiIX3jTIgXuFkMx/Xr+u4Ks8eWiM4yGftxQN1h9VmwHqq/sb7Ib/H
         /lOmNtkFzch0ULTyPEsN3RIlMB6ZF0Wwh+SRyUJd+DONiiEo/HewDQ6t/ZXQewWMia2I
         OIeuGXQ7KqrNXi344ZCSQHGu4JP5AUeeDbhTWj3W8G/m/ojwWXc9BCmst5XnqUoiP1iU
         nCO1UTHQTHgX7HUtAyzUBM9vyjFReQ2Mpt3y+AYvLTX62x2AKhzhX70jGfO/6ClsSk+9
         aLppYNCSvaJLLiPnjhK3ORHyCmYSrzd+Mdb454SJcTDhEI83twuxEAdHCTR1t5axJQl5
         aysA==
X-Forwarded-Encrypted: i=1; AJvYcCXfrvnAurqyucKm4lrfQLuGJG/eUuh/XrbIK5xQ/Wslu8D8fzvepCcywNUxQjyIpFDlijTwAKd/Da58qztrRBZU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt54DleH4s2h797jaD7l/tvmf5tFZNIEgtRWKv00JSUcfNfqbT
	9hYKpD0UZirMjzSbIWaCkL4ivubc8zU3dS15V0LbbAmWq/mR4jUyz763
X-Gm-Gg: ATEYQzy7hw51De3jUhex1NmnYz3dUSPZUQnWMHGSpon4Mq3DTX++XZfLXQqFa9pLqTk
	Fyt5kmtmlhv/b+m4jjDhNjB4L2vjBNZFiBRxS3JFpLDJwdQmicTqUogQIHOSA5aHvKeSGMXEmue
	nlTJgqMiGyCFghMfmQxex84y6tWUDdrN5JgGx0CsHH/aBfSN1sHyQMJEyU/Zl+9C8Az8sklJITn
	vo2jPKiTXTON3MF2LmE49jT3/3ko4crdpoi89H32S1HGuncdESBvX17hXneDKVyehgLiUxZ3DBM
	nB8WLUC6f5babwf6qR+9w2FUryUFt+kjQD+SgPuu3tI2WZmxLH+nvS2hNGLkMkQDyY7KTyCIj7V
	S7dA+r9PTFWg2SZhAonBYHxEYI/kE62w4MVn3BEDaZBzPlP0kn9DwIZ38/uC5WVTAt+NmbQmkG8
	3mij6Q74xWE3//hgnG7fG9B6LkiRnKgssyEMLjW29zyH+Umx4kn52Yh7ePphjh/9rINIOzdN2Tx
	Ak2p1nMRhB+6SztMMOpKYrw94j/aOaD5Cb+Sw==
X-Received: by 2002:a17:907:3e07:b0:b98:2888:6ee9 with SMTP id a640c23a62f3a-b9b507968c5mr599562766b.40.1774801135869;
        Sun, 29 Mar 2026 09:18:55 -0700 (PDT)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-084-056-106-044.084.056.pools.vodafone-ip.de. [84.56.106.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1a5924sm180808566b.32.2026.03.29.09.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:18:55 -0700 (PDT)
Date: Sun, 29 Mar 2026 18:18:52 +0200
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: miguel.ojeda.sandonis@gmail.com, a.hindborg@kernel.org, 
	acme@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, lossin@kernel.org, namhyung@kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v1] perf test type profiling: Remote typedef on struct
Message-ID: <kr2bfp43sqatdssmhzpmogs2h27ddbmegvaknxb6by24n2t64h@hv4m5myvswpa>
References: <jiwt5mjma2puv7kjbgploxx2l5tankjm4zu2tsa75qkckwnwjk@f7mz5vlvzpjz>
 <20260302235821.588686-1-irogers@google.com>
 <gfdliffsgy4j6q2vrilr6kapy3hczh4udszy4wcba6aal3ado4@hfeqa2eizu5y>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gfdliffsgy4j6q2vrilr6kapy3hczh4udszy4wcba6aal3ado4@hfeqa2eizu5y>

> On Wed, Mar 04, 2026 at 11:44:16AM +0100, Dmitry Dolgov wrote:
> > On Mon, Mar 02, 2026 at 03:58:21PM -0800, Ian Rogers wrote:
> > The typedef creates an issue where the struct or the typedef may
> > appear in the output and cause the "perf data type profiling tests" to
> > fail. Let's remove the typedef to keep the test passing.
> 
> Yes, makes sense to me, thanks. As mentioned in the previous message, it
> sounds fishy to me that perf record and perf mem record capture
> different data type -- I'll try to get to the bottom of it.

I think I figured it out. To reiterate, the problem was that in my environment
this:

    $ perf record ...
    $ perf annotate --code-with-type ...

was showing a different data structure for workload_datasym_buf1 (buf vs struct
_buf) than:

    $ perf mem record ...
    $ perf annotate --code-with-type ...

It turns out that the type_die for this variable was derived differently: for
"record" it was going through check_variable, for "mem record" through
global_var__collect. If the type tag is DW_TAG_typedef, check_variable tries to
figure out a real data type via die_get_real_type, which says this:

    /**
     * [...]
     * If the type is qualifiers (e.g. const) or typedef, this skips it
     * and tries to find real type (structure or basic types, e.g. int).
     */

But the underlying implementation doesn't actually check for DW_TAG_typedef for
some reason:

	while (tag == DW_TAG_const_type ||
		 tag == DW_TAG_restrict_type ||
		 tag == DW_TAG_volatile_type ||
		 tag == DW_TAG_shared_type);

By itself it doesn't look problematic, but for some reason datasym test was
producing such a code, that had a chain of two DW_TAG_typedef in a row, so that
die_get_real_type was returning a DW_TAG_typedef again.

It looks to me like a deficiency of die_get_real_type, and the following code
change fixes the problem for me:

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 9267af204c7..de152fae1d9 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -279,6 +279,7 @@ Dwarf_Die *__die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
        } while (tag == DW_TAG_const_type ||
                 tag == DW_TAG_restrict_type ||
                 tag == DW_TAG_volatile_type ||
+                tag == DW_TAG_typedef ||
                 tag == DW_TAG_shared_type);

        return vr_die;

Does this change sound reasonable?
