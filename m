Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C4263C7F
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082151; cv=none; b=O8l1R+VomWvIeIOqqPBikiR0bvMYOhqDrekSHB+wZ1naRYQAGW/1y9W5r8M5RxcPbxVduWSZ4M+f5qkXP3AOj+o/TKUShfIiqlgAiTBE7YhRaerWEEtB4IhDmHqlPbDikV7heo1jRg0hP5gMJfkgcPZfLKsYrCJMxo/hxWXuR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082151; c=relaxed/simple;
	bh=ZFRNt+QYq80hmkneSZxTCry1iKmBOR0+9hD3Vcm/fuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPLBVXNj5x13mAnfSacevGruAzYTnXg75mK61vbVP3UEbTTRHLTfrxc7VFodrWz+e4zXawNDsP2JhEWGAziPxCG9EqaW7SkNDWapf41oOBc73tIjz51vvU+tWZZwk/KrCggTIYmjQ1t6Q2Mj2oE1sdUF58uVLbS4MioFmOyIgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LxMo8mi/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LxMo8mi/"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15e2dab83eso29748966b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1787082147; x=1787686947; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PlQF8Qs7MFJZakJBkZrZnSWy3SJ5TDYPKP5+TwgUlDM=;
        b=LxMo8mi/FY55FV1IJcMtSxZ3CzHKEJRaCkmB83NyssxUXyHM79hwc8IRtpUrefm+Fn
         7ej6HycRIzwtW6WiyoC/2VUakJ/j/VBoDjVf4/rtKZMdfwUL7Vi7rWlQPTYyN62xs7Fg
         59kIDFMzSyDmZyU2eg5GgE/2Z+D1uNdNPX9Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082147; x=1787686947;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PlQF8Qs7MFJZakJBkZrZnSWy3SJ5TDYPKP5+TwgUlDM=;
        b=k12Mg25m8E6hlW5emj80A6PDqRUKjQgzKuVhidFa8793E2NIAGz5TIITG/uBvNLjj+
         u/OI0CgGL7FkD6ZrEQx8VxZziDG9cyCiqyPvSLZ/usLhIQKlQspGfSEHmzoe/3FzZFKr
         WLp9MtVeDYDiIlaUhfOsMpm3NnYzirngHbrBMnCyYc0Yu2KEHQuSX98qMaqfbSJhkE3m
         mRxyVMrgOOC60fNWaiDHlNnJBeqKH2lcTEzH9p0OQjLch/yrO+WmZwFzE2BoyTNlfpP3
         nMyAXoGHt5MaKhIaw5RBpMeV+fkbQxh/sde0x8YxJ+b3+2F/VvxIJh4S5uh8tSrcW5zQ
         Ib/A==
X-Forwarded-Encrypted: i=1; AHgh+RoT/gDylAph+WOdlF1YVmeb0Ie9QF2REcFmX/4SaBsftM/Je/8Lklrs1cFFde1KqkA7VxkUIM2lyUMgxjYqushD@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+W30KZxwemcWNHjEPHr8Ab3dsDvrulcF8fhhaVk9Bdmg286M
	SH4leTn+rUaaIfzlz9ucS7MH7dUMWPlSGJ6VQ1wlh8CNSw/JLSNcXDRu/xszGzT5l9mno6v12FT
	WWqc4SSY=
X-Gm-Gg: AR+sD13aqXa70Jf7qjK7+Z1a3QYElR+UYJ5jK3cVsnuUD1w5U7qVIgwW/V9E346uLPB
	3W3H14NIeEGB+kRrfkOAxqZZO8JWiwJLE7QVVHUO+bTTzP/9lNRzVNrWnkU2aoGAKALtbHzTRt8
	7b0ihOR/hsJz+NDCwseIR3iZVvmX3agU0IAe3O+CT0UuXyPvZQJJTzjnuHLlyugj3A2KTh36OZq
	UUaxUGMqN13dlTFCCNToCtL8lcIxU3qtks8ccTBVUt6K1fUQ49kfzb+qYk5pdUmOKhZ0DmA7eXY
	VIBjLrUJW2BvdmQ0cAFKjU4trJqsv6f6ZwE5+p1POnoU11YsrafVPppMHrrKk71hptopgGx1FNT
	TgSRgkgmLjp/g3AguluxoBg1REtp2ak3ff4T5CGHQf5rilWkZujDM6r5lVWKoSeTpFmItNQDeMT
	k7sa9JlARUcFXdrI3ZwbAMq+oXqUrKDJvxDFbyRo6Ea0MMIu6WEv7Rr5KxxBr1WKBubQKez4a4F
	SYJXl2Px5oiW+/2ZQd4dr+9kw1RbWgkJe/0ng==
X-Received: by 2002:a17:907:8995:b0:c1c:2173:d412 with SMTP id a640c23a62f3a-c223bd48efdmr44399166b.1.1787082147348;
        Tue, 18 Aug 2026 12:42:27 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217ff7e1a2sm232000666b.14.2026.08.18.12.42.26
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 12:42:26 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2055f5a993so16735866b.2
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 12:42:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqtK60bbrPAq0PK8+7J7W+q76A6vMsACdpRWXJmAK4OeNKufwNI0C/hbLEE/iVUXWMCLIsZah704P0fPEaX5Fvh@vger.kernel.org
X-Received: by 2002:a17:907:9d11:b0:c16:242a:472f with SMTP id
 a640c23a62f3a-c224ecee4bdmr38598166b.23.1787082145790; Tue, 18 Aug 2026
 12:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aoLUyf6R-TBxOgjT@gmail.com>
In-Reply-To: <aoLUyf6R-TBxOgjT@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 18 Aug 2026 12:42:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfHkbCuZ1bZp2+0-+6KjsQxmyJ79StB-a0rO+cZN+3oA@mail.gmail.com>
X-Gm-Features: AcwNN1WQHB2ZCjw_UgdTSRFJPzGxxZDyoRS7aBKNt2B2OFNBxso4KpHDY8NDygw
Message-ID: <CAHk-=whfHkbCuZ1bZp2+0-+6KjsQxmyJ79StB-a0rO+cZN+3oA@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events updates for v7.3
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Aug 2026 at 02:30, Ingo Molnar <mingo@kernel.org> wrote:
>
>  - Patch series to fix a category of bugs [..]
...
>  - Series to fix various uncore [..]

In today's small pet peeve, you seem to have caught the same pointless
verbiage bug that I've been editing out of other peoples'
explanations: I really don't think it adds any value to talk about how
one issue was fixed by X patches, and another was fixed by a single
patch.

Just say "Fix a category of bugs ..." and "Fix various uncore ..". The
important thing is what got fixed, not that it was a "Five-patch
series fixing XYZ" like some people seem to think.

No, this isn't a big deal. I edit other peoples messages a lot more.
Some people seem to not understand imperative mood, and keep doing
that "Series fixing XYZ" thing.

The only reason I mention it is that I don't think I _used_ to do it
for your messages.

Or maybe it's just that I've been looking at too many of these, and I
went "Not Ingo too!"

Feel free to ignore my little impotent outburst.

              Linus
