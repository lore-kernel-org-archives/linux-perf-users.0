Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHW0vcCr"
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B963D67
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Nov 2023 10:30:46 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2853347502aso1560816a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Nov 2023 10:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700591446; x=1701196246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gTKGeplgoyva/GvaQsbatqUyou8W+loj6cRdwnLWlOU=;
        b=dHW0vcCrcUcZSMWGpFU5ED+ubgImcf3uE5V5T9AzGERIWYte7X4h5X64ZTCepa8y58
         0lfBQDptsHSEJ9paovE88MGdMDElDO5Yu/B2CRKDBLz3tApko4pnt31os3Qlo7+QcqMG
         IPoX8lPbIMeEsKAEKuW5k0jogYCmG5OY2OuWUGt499uvnthx4Ygcd0S9lXEdTvJSHPCj
         ctmOcC92U+IYBln7+lY1gL6oTtxJZPZiItqSp7tpOAxYTnUESIj7xvkeW3VLVDOtfmLw
         nPvYK8vI/PFOzeAK86UEUz4OPZ3TUt20rPBnrwRAJeUTjKCzsZH1Lc4Ptq0Es7kgkP59
         fIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700591446; x=1701196246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTKGeplgoyva/GvaQsbatqUyou8W+loj6cRdwnLWlOU=;
        b=cQmJFVRUTR987bVXAt67JA3jva5JpEfwvnrKDKLnYWLjWpTc9qP6nZn1BeZs6Ozqyi
         ija9JXR/YUgNm9p8zzARndl4nyZd8o3aVPHYk+tZBh/P24D1HI3cKvjbsm6Dh4DnJecW
         3iLOyYYnbPmQNGpap9ies2jGwbj2bC8W60Ec+0lvzXcB2we1x24LjY8+/0lATpjzyg8Q
         OYR1XyXbCzFN/96WFl+WRtdVwKIX5wrZ4SKJXZQzsRRUebt9RDgf1Gfn+wMAr+c+DsDn
         MuL/4uSnNaOIAaKpRNfLxyZf5O4Oe3isyl1tQUrww+HoT4sMPLQV4GfVLsHdHQuxLxBB
         YRRw==
X-Gm-Message-State: AOJu0YzhfCtgWyexV/2ujpfLzNSsjzA4f1lbqfOSYgyrlLc0v7UnEwGv
	4bHrKIPZNqP8gw5XtoNKihMOBqhGRTG3tPb+CUSyXhBpjHrxX6t8
X-Google-Smtp-Source: AGHT+IHcCh+vr6y0Q6FyoF0qvGFJeP2L2zA0ROqw4CJgG/Ae9e6bkE+il1722BLKCdSCQ34X89ekhAmrcSHx37eEotU=
X-Received: by 2002:a17:90b:1c10:b0:27f:ebfa:1112 with SMTP id
 oc16-20020a17090b1c1000b0027febfa1112mr39629pjb.5.1700591445579; Tue, 21 Nov
 2023 10:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFjbc8G+q4sFpO5D6PqbDFNbHHpgYZ_2ADV7sUp7Lw=AefprJA@mail.gmail.com>
 <CAM9d7cgXWTSKTVCbSTdQnPqoHqu50UEKdPZ6nfNgdmTZPo0Cug@mail.gmail.com>
In-Reply-To: <CAM9d7cgXWTSKTVCbSTdQnPqoHqu50UEKdPZ6nfNgdmTZPo0Cug@mail.gmail.com>
From: Pablo Galindo Salgado <pablogsal@gmail.com>
Date: Tue, 21 Nov 2023 18:30:34 +0000
Message-ID: <CAFjbc8Hh6o4-7VHDgozmMdqvcEz+9ysqk5JBLdfJW6uKazMYLQ@mail.gmail.com>
Subject: Re: Perf support in CPython
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I'm curious if it works well when the compiled trampolines are reused.
> IOW what if two different trampolines have the same address (one used
> and freed and then another came to the same address later)?

The compiled trampolines are never reuse. As all the trampolines have
the same native code
we have a pool of copies and we assign one per Python code object and
we tell perf of the assignment
by writing in /tmp/perf-$d.map. Trampolines are only freed at the end
of the program.


> Looks interesting.  Let me take a look (after Thanksgiving).

Fantastic! You can read about the integration here:

https://docs.python.org/3/howto/perf_profiling.html

That has some examples that can guide you to ensure how it is supposed
to work. You can check the link
in my original message to explore where the code lives.

> Ok, I think it needs more detail..  Have you filed a bug somewhere?

No, I still don't know if it is a bug or I am messing something up,
but it is certainly mysterious so I need
some help figuring out if it is my fault or perf's.

> I'd be happy to help.  Thanks for reaching out.

Thanks a lot! Looking forward to working together on this!

Pablo Galindo Salgado
