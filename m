Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiH08J5j"
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F07AC
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Dec 2023 07:56:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1f8f470903so515363666b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Dec 2023 07:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702482995; x=1703087795; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=18q72FJA5B9ChgH1KtJeeZw/9OT71CxKYwOE0Gkl3A0=;
        b=HiH08J5jMcqwNe8qEVrX+a8MMKM1lTRG8kBqBlWupkIarV3Pokq6mFFy/Cd7rRu+fE
         sC7yNuZ2d8de/2S20jlXgaZZW6EGMGw5rxVW/Emz7zIuqLEPxL/Zm9t5FJMF+/RNy0NG
         iC1hcA6pvDjC+pKqXoERzk7tyiy7Rx400Qbf8CliYCYs6BZO1IWOPyxGqRe1ZlhLU5BE
         aB7tH0Ctl6rFMp8cCIfHV2AXLnISLypFWUsY7Gdtf2Rwsx47sPyZnIWbRlZLzx1+7ibh
         oQK3KfH2uGncwKkn6+yan8rl4RpVqCaQDB1TfdeAAKiCPDZuKnWuie6IJrGFeuyavH3h
         qhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702482995; x=1703087795;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18q72FJA5B9ChgH1KtJeeZw/9OT71CxKYwOE0Gkl3A0=;
        b=wsX7wGrAbSdis31V1SUA6a5e0ebNQaqMcmZQsYmuZ5n4R4CrgCNEs/Vtge5ovltcdu
         xlP7XbKS+UpdjEpvUG+IfZNXmDRvxuk7VTU1SIQT+loMTBa2FZilOnzTDSPpfrWWDrgp
         FaKN4rVmBtrMYMUzumjzHB+zQJQtZwd+iyf2Igk21c/4/QdhSBWsbXgVolvUg5ocUmps
         olsYt/lbISmRPT5BwI43Lgk/Cdjc+Awrf1VI1ygPXjDGmTLYnDoEiGJ8VzDLUmSoMZZ7
         Gp3WO5hXkLSTRwWmpjkP6z8ET8I9fo4NHj28q90I9TLCF9gPiI/Uy3STdL5DuuwFRupF
         8Rrg==
X-Gm-Message-State: AOJu0YzjRfB26gXGHLS9cGeRip5n8lIIku5HJHcwVgAi/b2EBihWbFeF
	YATOI4HNN5iZsq0FpanzOY+qZAaID/csT5YRQ5IrKTECEjOiIw==
X-Google-Smtp-Source: AGHT+IFuej3FbfrqKVoZYLj8pB4hgaUVuLnFj6Dj+b/wzGQJi/FyMedCG8KCzpnv2wO+VNj1S5NZB9xUfbfcDNFmZ7g=
X-Received: by 2002:a17:906:2208:b0:a1f:a4ab:ab26 with SMTP id
 s8-20020a170906220800b00a1fa4abab26mr2569434ejs.132.1702482994944; Wed, 13
 Dec 2023 07:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Eisel <michael.eisel@gmail.com>
Date: Wed, 13 Dec 2023 10:56:22 -0500
Message-ID: <CAB3D8BHdPXWuXxYOSU9rev=Yw46xomXsLjYHJy6=Z_0UwC6nvw@mail.gmail.com>
Subject: Incorrect perf back traces
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have a simple program that I compile with `-O0 -g
-fno-omit-frame-pointer -fno-inline`, and which I record with
system-wide recording as such: `timeout 3 perf record -a -g -F 99 --
./program && perf script > out.perf &&
../FlameGraph/stackcollapse-perf.pl out.perf > out.folded`

In out.folded, I see various incorrect stack traces, even when I add
--call-graph dwarf or --call-graph lbr to the unwind strategy. I'm on
Ubuntu with an Intel 9900K processor. Here's the program:

```
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <cstdint>

double a(double aa) {
  return sqrt(aa);
}

int main() {
  double aa = drand48();
  for (size_t i = 0; i < UINT64_MAX; i++) {
    if (a(aa) == 0) {
      std::cout << std::endl; // Side-effect
    }
  }
  return 0;
}
```

Here are some example incorrect stack traces where they go straight
from main to sqrt and skip over a, with various unwinding strategies:

DWARF:

a_39391_[003]__3819.799248:;__libc_start_call_main;main;__sqrt 91016627
a_39391_[003]__3819.817492:;__libc_start_call_main;main;a 71222327
a_39391_[003]__3819.831741:;__libc_start_call_main;main;__ieee754_sqrt 62644598
a_39391_[003]__3819.844274:;__libc_start_call_main;main;a 58633093

The first and third lines show main calling `__sqrt` without going through `a`

and these ones with LBR unwinding:

a_40294_[000]__4306.958241:;_start;__libc_start_main@@GLIBC_2.34;__libc_start_call_main;main;a;_init
69630243
a_40294_[000]__4306.972230:;_start;__libc_start_main@@GLIBC_2.34;__libc_start_call_main;main
63241775
a_40294_[000]__4306.984884:;_start;__libc_start_main@@GLIBC_2.34;__libc_start_call_main;main;a;_init
59031331
a_40294_[000]__4306.996696:;_start;__libc_start_main@@GLIBC_2.34;__libc_start_call_main;main;a
56209420

The second-last line shows a call from `main` to `a` to `_init` rather
than sqrt.

FP:

a_40380_[001]__4360.292014:;__libc_start_call_main;a 84184457
a_40380_[001]__4360.308855:;__libc_start_call_main;a 70243465
a_40380_[001]__4360.322906:;__libc_start_call_main;main;__sqrt 63725332

The last line shows `__sqrt` without `a`

Here's a snippet from the compiled binary showing that main does
indeed call a which in turn calls sqrt:

00000000000011c0 <_Z1ad>:
...
    11d2:   e8 59 fe ff ff          call   1030 <sqrt@plt>
...

00000000000011e0 <main>:
...
    1211:   e8 aa ff ff ff          call   11c0 <_Z1ad>

So neither were inlined or optimized to a jmp tailcall.

Does anyone have any ideas how to get better stack traces? Is it
because perf is running async while the stack is being changed while
it unwinds it, and if so, is there some tool on Linux that pauses the
thread each time it samples it?

Also, while this is a small representative test case, the above sort
of issues have happened to me with every single program I've tried to
profile with perf. I'm on Ubuntu 22.04 with an Intel 9900K CPU using
perf version 6.2.16, and another person confirmed they could reproduce
the same issue with perf 6.5 on Arch Linux 6.5.9 and without the -a
flag being given to perf.
