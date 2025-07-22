Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3919309C
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202666; cv=none; b=fvw+DpdRizBkTYekNrf2mpMpoO+X6Ykh/6TJjdfhznj3MiIA3Wv7S7oM3k3WFqnqYNzNG2pSBpuI9UHHE9RHAT8hIE6C+V5CdEIZ1+rcT1p4sUeypAVSYIfKdj1zYSvRsMIwfyU4bXM+CEHYFRz7FQEsbLO0LiMYiePj9XOZeIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202666; c=relaxed/simple;
	bh=OIgAdLuErVs2/A6r/aGC/cMTM9FQgoTIcHs9dhoSMGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrNv0dCK/VJptj6BDAPxJYfS90t5x87v8Nv6DBdzh4XqQOKsPtUVkG7Qe0wLYHFO52x1INFbWF4Kx3qLUT5rDD9oG0hU6xXDXlbzETAjTfWQzXk6NNhAXV5JvlVg7l9I4LIi5RGOCqBGOzh8RBvwgZ5JMQ0jgqLPVwPLVXW/+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zI0ZCOq5; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zI0ZCOq5"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so6125ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753202664; x=1753807464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/J9c44B2rfUEXqOaK5vBmjRcGZBEhOA4d7CmtYKTbM=;
        b=zI0ZCOq5W4dnPTfLMdKUYmiC6NU0GVRJVlY5jjith8s8Mqc321enjMQhSntH1xYjPD
         cvhmNnPKY+om6/+sN84rx1YwUC/FTpdTZJHZeGlzsMqXUhM5wGw09TNlEbS0eQS6GcaQ
         TsvSrtQBgbyGSgb/Jk76h/rfAQ/G5E5K6eTAJ8h9T5FmJk4QlTURSfePYmcIlBeXT/h/
         pDU6LhaBYr2DoWLUzNSfv0KXSK95xX4OjH+VZ0cQbn1VIEMQG2zF38+zNUccbUmOfCki
         5CYuVGjD+FCJx5ANWUdJqQ2tI/j54LuxuAaO8c09W2VLdIA+Pl9ls6kB0zI2it00Fv+S
         N6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753202664; x=1753807464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/J9c44B2rfUEXqOaK5vBmjRcGZBEhOA4d7CmtYKTbM=;
        b=Ym8iRTFzvr3ublGkm6rJkPoE37snrvmyeOdhMNiyhSr6bRjvpIkg9RgvdsiMgUzJGL
         WlxDE00/rUNVeg6cZNLcMfod7zxWBhzlqbcHtkjDpvD55rCt1+VbGGpIMh8N5LB0ZR9W
         QM5CyIy5F7izuqrYY9ocPz5bW3ONp3Qct3mealmTy9bomjOIkA0DtZ2h16P+zb7qiKLp
         DapA8ei2aPjH1cr5oyhDdTCDxz6xuap4jBh2pgVs1cTnwiE2ZIRZyArLANZau4ZTzZpM
         /LbahFe6CJHppLY3EVeXEWDsTbPZf4z08j5s5aMwtzLhBlvFUmYOIzIjXnv02RP3K6Kn
         S3+g==
X-Forwarded-Encrypted: i=1; AJvYcCUWJ1gwFWEa2NFRNi/JsOtJ1CBxrrOWaMjcyBKpCGKQK6gwqwpz0JFekQxloIn5W9czfHXX4VFRiIF3weDazuE1@vger.kernel.org
X-Gm-Message-State: AOJu0YznQzUGe9qstp7AcGqO2VGzfgbjtU1SQ9lTNy/cnVxuuyphEKgc
	EjBV3/45c0Plv7lfY1W+ZfVHi+4qrA7NiCq4+DKNc+83eor5xPyZyW4Lwr160uW6z2Uy7phPtY9
	Qwc2n/E/PS+UPqL5hSgWa6myGcaeCxUpSLjUgaDIk
X-Gm-Gg: ASbGncu5ILKfbi/rHhvFwhVoy1opEXUfWQ5W3zkIW8OlJGWLmRtYlMt/JuoCwOSWrV3
	0JpihDOCAzXqUMMvWeguJJtEcwGNB0tyaO2KQEOgvm9M34LBXLVeW4co0+7WClRafpd3I6v+P8Q
	XoqxpzVda/EysnoScH7t5ShtirxYA5f3yiepG5N6xLvwc8V3EmrJYm59tODsjhGb3bq6ZJ/4lVV
	hl28O5Q5lQpzhqs8mX1aedHvxbuzLp0iRQO
X-Google-Smtp-Source: AGHT+IGfEYLYe5Io1K4VZvSr4/cF5bO7gX7epuRu2YdmefaHtqEtYNEemlXzdWnjClvSJUyhPU3cExio1XvDmsqvslw=
X-Received: by 2002:a05:6e02:214c:b0:3e0:51fc:6e8 with SMTP id
 e9e14a558f8ab-3e2c043f895mr3953445ab.15.1753202663337; Tue, 22 Jul 2025
 09:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626054826.433453-2-irogers@google.com> <202507050736.b4hX0Xks-lkp@intel.com>
 <87o6tcrzh2.ffs@tglx>
In-Reply-To: <87o6tcrzh2.ffs@tglx>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Jul 2025 09:44:11 -0700
X-Gm-Features: Ac12FXy6DPlRgmtRMXwfgDfN-fUO2i-M22mO1ZiFnmHJ37c6WMrgsL94ksjwfgo
Message-ID: <CAP-5=fWbmo3ejmeWbweSk5waPtS2VTc1obtaWiibZC3cVmvVvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] vdso: Switch get/put unaligned from packed struct
 to memcpy
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel test robot <lkp@intel.com>, Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:56=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Ian!
>
> On Sat, Jul 05 2025 at 08:05, kernel test robot wrote:
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on tip/timers/vdso v6.16-rc4 next-20250704]
> > [cannot apply to acme/perf/core]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/vdso-=
Switch-get-put-unaligned-from-packed-struct-to-memcpy/20250626-135005
> > base:   linus/master
> > patch link:    https://lore.kernel.org/r/20250626054826.433453-2-iroger=
s%40google.com
> > patch subject: [PATCH v3 1/3] vdso: Switch get/put unaligned from packe=
d struct to memcpy
> > config: s390-randconfig-002-20250705 (https://download.01.org/0day-ci/a=
rchive/20250705/202507050736.b4hX0Xks-lkp@intel.com/config)
> > compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project=
 61529d9e36fa86782a2458e6bdeedf7f376ef4b5)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20250705/202507050736.b4hX0Xks-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202507050736.b4hX0Xks-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from arch/s390/boot/decompressor.c:48:
> >    In file included from arch/s390/include/uapi/../../../../lib/decompr=
ess_unlz4.c:10:
> >    In file included from arch/s390/include/uapi/../../../../lib/lz4/lz4=
_decompress.c:36:
> >>> arch/s390/include/uapi/../../../../lib/lz4/lz4defs.h:109:9: warning: =
default initialization of an object of type 'typeof (*((const U16 *)ptr))' =
(aka 'const unsigned short') leaves the object uninitialized [-Wdefault-con=
st-init-var-unsafe]
> >      109 |         return get_unaligned((const U16 *)ptr);
> >          |                ^
>
> Any update on this one?

Hi Thomas!

Thanks for the interest. I'm not sure how to resolve this.
Basically the story in the code is:

  get_unaligned((const U16 *)ptr);

is being expanded by:

  #define get_unaligned(ptr)      __get_unaligned_t(typeof(*(ptr)), (ptr))
  #define __get_unaligned_t(type, ptr) ({
          \
       type __get_unaligned_ctrl_type __always_unused;                 \
       __unqual_scalar_typeof(__get_unaligned_ctrl_type) __get_unaligned_va=
l; \
       __builtin_memcpy(&__get_unaligned_val, (void *)(ptr),           \
                        sizeof(__get_unaligned_val));                  \
       __get_unaligned_val;                                            \
  })

to:

  ({
  const U16 __get_unaligned_ctrl_type __always_unused;
  __unqual_scalar_typeof(__get_unaligned_ctrl_type) __get_unaligned_val;
  __builtin_memcpy(&__get_unaligned_val, (void *)(ptr),
   sizeof(__get_unaligned_val));
  __get_unaligned_val;
  })

which is then expanded to:

  ({
  const U16 __get_unaligned_ctrl_type __always_unused;
  U16 __get_unaligned_val;
  __builtin_memcpy(&__get_unaligned_val, (void *)(ptr),
   sizeof(__get_unaligned_val));
  __get_unaligned_val;
  })

so the analysis is correct that __get_unaligned_ctrl_type is
unused, however, I've also put __always_unused on the variable.
The purpose of that variable is for __unqual_scalar_typeof that
passes the value to _Generic. I truly don't care about that
variable but I care about it causing _Generic to get the correct
type for __get_unaligned_val (that value can't be const as it is
the destination of the memcpy). Why even declare
__get_unaligned_ctrl_type? Well we want the result of __get_unaligned_t to
match its type argument which needn't match the dereference of
its pointer argument (*ptr) - I accept that in many cases it
will. The value passed to _Generic is an expression and not a
type, so declaring the variable and using the variable for
_Generic allows this.

My feeling is that my patch is correct and I'm not clear how to
improve upon it. I believe it is a weakness in the analysis that
the __always_unused isn't having an effect.

Should adding new warnings for analysis on the code base be
allowed for this patch? Well the upside to the patch is getting
closer to not requiring -fno-strict-aliasing, or not introducing
requiring that flag for things in the tools directory. I think
the upside is good, I don't know how to mitigate the downside
with poor analysis by certain tools.

Thanks,
Ian
