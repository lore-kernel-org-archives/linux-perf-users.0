Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620461CD5A4
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599311; cv=none; b=Fom05jM7MYU1G/1M2RhB8qTqLvK2BFixJS8Xg+/W3Z6XMc3ZDBStdQSF+TnyrvNPcbkoy288YJiHBtTSN1ByAahZNSvSR4MkVrHhn/Qz4j9JvXaNnni0ykgO+OvKoVPvFqrLXTbh7MMq56NQgkAWIU8WGNMawpitgmh0fwNnYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599311; c=relaxed/simple;
	bh=0/bcKF9yNwfrpBcaWqzxl2cNtLLSxiplYVtthlumbnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEqZhoA0ySrVbCaBBDC+izjfGsLfftr8Sv6TvLofroKdQvOsMvOZIuNXoaZ78gDhHnihEx4X6YMZY75qvoPrGXd+S0RrtWIosyj2TfonGrTdM1FF7S7dedbL9mkDkGTv0Bu5szgDBzH++TpyU0EUZV8nK7muFBnR+s8rvO+bcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhbSAKqy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhbSAKqy"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fad076cd9cso19615ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719599310; x=1720204110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn/pRXgSi6IDLKLvgPYyyG0DNITGu/ajABHfGH5hZAM=;
        b=PhbSAKqy0k60uxTtbytGIRNtUcX+zkjuzi9B3bhchLMyttjmE2kGO9YyHbei6VfjJu
         zoy5SHpX1ZieN86IRKfhzRWF2NERQF0U16Ti28sLUmPaw6RGEd5/0pjx6S7s78UQp+bv
         PXc7jKCUI8wif/CHt9dXPFudG1YiAzAsv7SRyvvTslUqyE5W47Hpw9r/rd7zCTpx5iae
         s0bom6g9FDBrKmG5i9xCSJtPmEvo6vGiPSmF9X2I/CVbekJV4VOi7s9gBDWCP2GeAJRB
         ReBtU5r5UEDUcQY8ubkho42+cvn8vHzWNpuIOO+OgHSlR1xFmP7ORfO2Iko9svYHCH6P
         R4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719599310; x=1720204110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cn/pRXgSi6IDLKLvgPYyyG0DNITGu/ajABHfGH5hZAM=;
        b=I0Q+sqfrE7qf/IgBWFOn13Ut7+VNVHF+sh3SGONglXsHVp+lh/5OKRZCpf0ak7rgJp
         SAHLW/2tkPGxlqjK0FTGNTAcMf7DqeZ+dZSQ+j+chqrB0gZgF8kwGdJileNXpA8toS68
         NTLxxxVAwY7t02obxzlKRDa2sOP3jEx72AWOaD5XLWJ4kQso6HXeVi8Qi7UySFtSTXhx
         SmmN2+XoooPlM9Kk5FCKlHk2ZROZiao77JYIsqJQw/as7o8TmOnHnMOLkWerd9/d/ET4
         3Qbne/YImnS9O74TAMWnjpIpV0rofMKHA8kQe3w73rtlXbt2sLbpzO6ykMQ923zI/h/Y
         EbUg==
X-Forwarded-Encrypted: i=1; AJvYcCXKugxzcQT8rEbxZ8AWN+Qw8fsE+7ePIKuJ/Ygm/0Ldp8Z2Dwn72dKNy9oj9tLcvENHQv0rVZbLghV6k7x//fX+LCk4usK8SS9RHxUVojTwAQ==
X-Gm-Message-State: AOJu0YyZEr9jPVHWZnJTxvthMmeQ1sPbObEk3u1pN+7OF8TNTvCWmL2y
	tm9JO7V5sOmV1Oj3MxMNgathEnnVmGvMyP2YR94ySzEZ6lgJlCzMjgTV0nImZspPQT2FpcTzTbg
	DVxIQtbP4EjxLzE7S5pMZJs0kNOUTSyYJnoYo2JvBscCOQJcJoqXX
X-Google-Smtp-Source: AGHT+IGU3wvTawYw9ntraj8PCsXlOmTXouULiPhu9QOzt/Ei3RLpE5rVuu+G1M6oo9apNtNxArt+uBCaH7CKFlkDwoE=
X-Received: by 2002:a17:903:3103:b0:1f7:3764:1e19 with SMTP id
 d9443c01a7336-1fad81f2d2fmr214315ad.20.1719599309187; Fri, 28 Jun 2024
 11:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614213908.352840-1-dapeng1.mi@linux.intel.com>
 <df56c6e1-5d99-4cbe-abd4-772e7ff948af@linux.intel.com> <4f5dbf6f-3805-43b6-867c-2503ccec7c1a@linux.intel.com>
In-Reply-To: <4f5dbf6f-3805-43b6-867c-2503ccec7c1a@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Jun 2024 11:28:17 -0700
Message-ID: <CAP-5=fVYmUvYawOBtUc_-PVzsTQhpOuMx4wxA7bHjwaZejii8Q@mail.gmail.com>
Subject: Re: [PATCH] perf topdown: Correct leader selection with sample_read enabled
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:17=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
> On 6/27/2024 11:11 PM, Liang, Kan wrote:
> > On 2024-06-14 5:39 p.m., Dapeng Mi wrote:
> >
> > Besides, we need a test for the sampling read as well.
> > Ian has provided a very good base. Please add a topdown sampling read
> > case on top of it as well.
> > https://lore.kernel.org/lkml/CAP-5=3DfUkg-cAXTb+3wbFOQCfdXgpQeZw40XHjfr=
NFbnBD=3DNMXg@mail.gmail.com/
>
> Sure. I would look at it and add a test case.

Thanks Dapeng and thanks Kan too! I wonder if we can do a regular
counter and a leader sample counter then compare the counts are
reasonably consistent. Something like this:

```
$ perf stat -e instructions perf test -w noploop

Performance counter stats for '/tmp/perf/perf test -w noploop':

   25,779,785,496      instructions

      1.008047696 seconds time elapsed

      1.003754000 seconds user
      0.003999000 seconds sys
```

```
cat << "_end_of_file_" > a.py
last_count =3D None

def process_event(param_dict):
   if ("ev_name" in param_dict and "sample" in param_dict and
       param_dict["ev_name"] =3D=3D "instructions"):
       sample =3D param_dict["sample"]
       if "values" in sample:
           global last_count
           last_count =3D sample["values"][1][1]

def trace_end():
   global last_count
   print(last_count)
_end_of_file_
$ sudo perf record -o -  -e "{cycles,instructions}:S" perf test -w
noploop|perf script -i - -s ./a.py
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.459 MB - ]
22195356100
```

I didn't see a simpler way to get count and I don't think it is right.
There's some similar perf script checking of data in
tools/perf/tests/shell/test_intel_pt.sh.

Thanks,
Ian
