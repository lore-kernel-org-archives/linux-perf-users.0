Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85A1DF27F
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182027; cv=none; b=BcCZ8gsi1MZ1kIC8rIpWEKkfaw1nv0kDinDD+9U/G+Voo/kGo2R4XopO7wI+7IO2yrRIbx25/9wO3ZDWuUJUw7LmWoop92i+zopzALddsaw74ukXcFYAJkqSUQ4Xc7MkTAKe8+TjXI3FAFekuCZCQZF4bf8la97R3Eua88o7apo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182027; c=relaxed/simple;
	bh=wcjY/hXG4awaVM21LawncYu0yGH4eL1ioO+rk2Zr3e4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=A5JPpJPA/lB00x+QZVZ9cIzy2NYAxcyuC6b/eXtzsbzbQLiRzc14iRUTqkdX5lZkpfsz7d2SWVhyT3T8BA96lov1DvcNgypwxQcE1sDKe6UGBjiuofkKnxDtAWgCwhSNj+cbEw5f7CRPHRVRIr0W5lA889qPVmWYTSxZv6RYoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/dTHLKe; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/dTHLKe"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3b3f4b599so346225ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729182021; x=1729786821; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P+BatH650EPHbmw8K5ochYPOn3PEcP0FGy0mTwN1mpU=;
        b=M/dTHLKexMI39buFqqKgdc/QiMeNH1vx7+qsD1dvowsPRUBhlGYaK960tV1casmS9w
         cQOPUvdh5cz1KZVFI+ZgYavALTmp+vNDTUfIVjKI01njXIqpEG/2rUvUswVFxnx10jTM
         QJWEcEZ+b2/XBJb7QX+m1WiC5NlpxNKJ0kscP3tpDKbgox1RGjzhMkvWMkzFP4Y54wRD
         1w2ZrLFFVmiOtk63Ujbphp7ihyEiGUJQelHTABpYWV7T8OofNWafm4LvTKbRFlhs5Bx/
         gh5zu86ZzDZMNaOmd4T+cvdNyGYss/X9VgjGcL+/GCKvAIt1VWC3jcUz6je+9FMjOjUM
         cEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729182021; x=1729786821;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+BatH650EPHbmw8K5ochYPOn3PEcP0FGy0mTwN1mpU=;
        b=q1c0jv8cnQ9Q2yrHfbyu9HGdUa/NjnrudXNpuZa5KDpcRH8eROwCf6HAjrh0neom9f
         0+0ynZHjtpZ+U3/aFENGOdvZ/0kMb4psSqD5jaKht2aYlOdqo3RCvqFxOQkvXSgNByoj
         MHHqO9MVwfCLfemCFt4k4TXomdlp+LKNNm35ABp1vCfTUUHbhJwPv6sFJ9Sqe0vwcfRo
         +JLn0vHQ2qt9BF8V5aZovw1DqOuIKZ3nZSrBCXMu34gZvSsDpmQEV6SwaN77oGzq3VXj
         7NyTEt2Ka3p209fCjPBNDy8Qi08a9Yaz86HwQtemd233ea31Pf3+BJlgfSXDKc876Bpg
         70/w==
X-Gm-Message-State: AOJu0YzvTLu9BNgyv61mtEPSJQirvoZlc7Z7IbnRTwqjyoSfThXbjurk
	pqD0LESMR5K3C+wL4uco3nZVvNuBX3HECchslLk4JZq+ykqncKSXqXooTAFOfBCJmW7IbXjjgzo
	jt6Xceg40sZLnpQmCUTWkM4r6TZLHvHKH2Ms9uCWhl48JT/w/0Wap/zo=
X-Google-Smtp-Source: AGHT+IGgIrvcwAcWjJaSi3duB44hJB0v29WrGJxLSwlSo52IQRHN39+x/dHs7IIzkWWoW/03xV9VO43awEIDRnY2fgk=
X-Received: by 2002:a05:6e02:1b06:b0:3a3:a053:c0ad with SMTP id
 e9e14a558f8ab-3a3ea04e3e7mr4696195ab.25.1729182021386; Thu, 17 Oct 2024
 09:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Thu, 17 Oct 2024 09:20:07 -0700
Message-ID: <CAP-5=fVX4hOUq-Tni8ZRHcX6p3nrLuWaNTx8PvCU0sbaO=XvMA@mail.gmail.com>
Subject: Using the perf python module with address sanitizer
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I just wanted to capture/share the steps I used for getting the perf
python module working with address sanitizer. The process isn't ideal
so hopefully others can suggest improvements and possibly how we can
make this more automatic in the build, or use for automated testing,
etc.

To build perf with address sanitizer you add to the CFLAGS by passing to make:
EXTRA_CFLAGS="-fsanitize=address"

However, this yields a python module that fails with an undefined symbol:
```
$ perf test python -v
--- start ---
test child forked, pid 712715
python usage test: "echo "import sys ; sys.path.insert(0,
'/tmp/perf/python'); import perf" | '/usr/bin/python3' "
Traceback (most recent call last):
 File "<stdin>", line 1, in <module>
ImportError: /tmp/perf/python/perf.cpython-311-x86_64-linux-gnu.so:
undefined symbol: __asan_option_detect_stack_use_after_return
---- end(-1) ----
18: 'import perf' in python                                         : FAILED!
```

To resolve this issue add "-shared-libasan" to the CFLAGS:
EXTRA_CFLAGS="-fsanitize=address -shared-libasan"

The build needs to find (on x86) libclang_rt.asan-x86_64.so which for
me on a Debian derived OS wasn't on the LD_LIBRARY_PATH. I found it
with:
```
$ dpkg -L libclang-rt-16-dev|grep libclang_rt.asan-x86_64.so
/usr/lib/llvm-16/lib/clang/16/lib/linux/libclang_rt.asan-x86_64.so
```
I then built with:
```
$ LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/llvm-16/lib/clang/16/lib/linux
make EXTRA_CFLAGS="-fsanitize=address -shared-libasan"
```

However, still using the module wasn't successful:
```
$ LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/llvm-16/lib/clang/16/lib/linux
perf test python -v
--- start ---
test child forked, pid 720500
python usage test: "echo "import sys ; sys.path.insert(0,
'/tmp/perf/python'); import perf" | '/usr/bin/python3' "
==720503==ASan runtime does not come first in initial library list;
you should either link runtime to your application or manually preload
it with LD_PRELOAD.
---- end(-1) ----
18: 'import perf' in python                                         : FAILED!
```

I resolved this with LD_PRELOAD but there is a leak sanitizer issue
that doesn't relate to importing the perf module:
```
$ LD_PRELOAD=/usr/lib/llvm-16/lib/clang/16/lib/linux/libclang_rt.asan-x86_64.so
perf test python -v
--- start ---
test child forked, pid 720967
python usage test: "echo "import sys ; sys.path.insert(0,
'/tmp/perf/python'); import perf" | '/usr/bin/python3' "

=================================================================
==720971==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 13628 byte(s) in 6 object(s) allocated from:
   #0 0x7fda504e8b42 in __interceptor_malloc
(/usr/lib/llvm-16/lib/clang/16/lib/linux/libclang_rt.asan-x86_64.so+0xe8b42)
   #1 0x4de57f in PyMem_RawMalloc build-static/../Objects/obmalloc.c:586:12
   #2 0x4de57f in _PyObject_Malloc build-static/../Objects/obmalloc.c:2003:11
   #3 0x4de57f in _PyObject_Malloc build-static/../Objects/obmalloc.c:1996:1

SUMMARY: AddressSanitizer: 13628 byte(s) leaked in 6 allocation(s).
---- end(-1) ----
18: 'import perf' in python
```

To clean that up I added "ASAN_OPTIONS=detect_leaks=0":
```
$ LD_PRELOAD=/usr/lib/llvm-16/lib/clang/16/lib/linux/libclang_rt.asan-x86_64.so
ASAN_OPTIONS=detect_leaks=0 perf test python -v
18: 'import perf' in python                                         : Ok
```

So somewhat convoluted but it is possible.

Thanks,
Ian
