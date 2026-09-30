Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033E52844E
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789999; cv=pass; b=qub9LiXNJvCr9VwMidRd9tONWJUpxDHMJId+ic828eyLottINj1dtAjMfKg7aQHZC2Vs9qSl8f6RTEhMYqmJHrcyVfvF8EbDoKoLiGOWWkjd+bJzGFlFHebRmdlv6EEXkCdVqSofF41jy1L3FLkbtkfOE7HQ1ApoiAdVi3Lqo9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789999; c=relaxed/simple;
	bh=KN/Rqtx7rGY8tNQcOlCkzLKItNYw0df2BnSud3LUPxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxEi99l74rS5gH8IzrPjMN3xYpDNe0Ebr4N9V3SmUkX4izO6jlH3To+ybKTeCrysbq6zNyTH1H/Ur1/waswSoI4dhYkIuOK6cC4cdgEqL9YiuOmRq0dEmFeRMr2UYwFdoY7Ot0NBT7Bo/ofTyp8fNhX5/sJA3mXHNu+OtJA5Eg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjvB2znI; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjvB2znI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so6295ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 10:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790789997; cv=none;
        d=google.com; s=arc-20260327;
        b=X2Vg4iRBaqkHi7i9YMJGggNtx38Uoldy9mF5Tl9ZeO3IV1VwD0XExPIiDZ3vx/5CQ2
         QlK2S/XfGpzSNUgZ8KVPZZYKNsiqbNOL9a29cJplaccyKy7CYFM4groAa/vFv/aS7Xa9
         mkNVLjCmDCDBTq/4OkZ35POoge11rjmORAp5bPkJIAoZAptSVCwg0gxWDJpeTKiZT2xI
         TfikImKYj0DPym9JhLXh6LSYi8XE39Ti8sKNsMyVUpvM1zoMTwL1pkTfKZTF3UKhG2PM
         IYqjy0vLIq9QYya6iVRRxItV6yfBTGe/Vgjph6ek240AY9Lb4Wc3AH+KHSNnn1QX0XqV
         CgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xeSOziaumI9XifhmcFeHCXHccq2sADh9JjkKw2o1NPs=;
        fh=/i8hHft2UGoMRBqsilQk2++Hl2Vcj3JXY9rRSiLyubE=;
        b=ZLdyvbkk3Nv8SozjpFJuoVjRcV1GjPwKrWhnYR9ZBMGpJN483XugRICLGUp2NVrqcZ
         aQmsvwQGgA7ZbAH3pZPDVX52fUsAHi0JdpOYNJ+Whkik4H3CpZiORTQjgpzjvBK3Ba6d
         qvySvmh9LqUchfhVhA0oGBqvFkKSIXsKR8M3gT3blrpGL3UZi4juKAHnpXpwVrmr/XSZ
         lwAaJlR4Avj99Rn8CzXkM+UXONilhxoavnZcgCTLy8vDQwjoj+ro7hXYqfYqWw0EGzn8
         +BEVoDj6vY2xEKw+UTRCDcE2Q+jKDoj5Gjik4iC8nZ8GCLDH8hktT9cJZnphvEWwGc7Z
         4asQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789997; x=1791394797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xeSOziaumI9XifhmcFeHCXHccq2sADh9JjkKw2o1NPs=;
        b=KjvB2znILURAlKkCUGNtfuYyGHhaAw7uRCpTsbRzFHJYmjJj1+C62XvJIA33lG6NcD
         24RLvQCxzlIFm7aucSI4HBcFob35qZ4w96q5/uBajzZbUNrEJmake+wgo0l/133Li+5z
         qDnUCb9t+KWu5ZUxgijFnpf+Gg6bk6W141cBMgTm9omXsq4ipw7Va+2vnuthMn04RKQu
         Fv0FzfeOKYKDfg/QeBtJW3eVRjGkpKIQ1M+IOJz0f6PAhGCT/8ky5oIOknfMBq1mNvqD
         d84LROdRCrvfEy7DZmg+jxxjBUFUUvPnxIDJMY1Ogj7Wr7hrLVY0UavPlEoX6MnymOpn
         h0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789997; x=1791394797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xeSOziaumI9XifhmcFeHCXHccq2sADh9JjkKw2o1NPs=;
        b=viemdcsDOpo74tA6qm8Q9Bp/mhGwKQRlya3ylYrzV8vvu+NrfGDwZpOxtmPvejgUFG
         LP89UqFKNVySHHNDnlF8qys5nvNqHRbp9gMRAkUh6RgM5iWAYGFfJDUqEjvy0LddL9J9
         lklWZgKIS7YVT5zhX/85rPpzKGkLm5RCmAuSsxiK2POnTNvjw/QC+JBuxoJMinMTTbYZ
         b10pDgsI6oEeH1/KmTVpeWBQfTeAaBmOnTiyz1nzT3yrcHZHmjxtYeaas4HvxTBvr4fO
         UtYsoviFZtetCeH7lRFAwZxo8rYkBTPJ3Te9e4bAIQXprrnWgRRaXfxmKtrGcgLpzHdZ
         LBwg==
X-Forwarded-Encrypted: i=1; AKwUvBw6fbZpNk0V7YbRRX+M94shF8cKPOcuTw0E9kLzc8gZcZ5JP9l7F/S2YuqoaUVEq8f9IBYDbMtY5/gSZR4CzedN@vger.kernel.org
X-Gm-Message-State: AFq9FYKL4b3qdZBpip42bxJswPUfvSViKVgy9VmpqGbN++x0orfaS49j
	IFv4YWCm2azs+CM9g0R7S8ESIEk5wUS6NARaJMfKTPJEcgHo0RnCrX3M1yrwwxi0KQkQ8YJmagN
	kt3AVeGfyfPREeqUCLZ0bbPotU/Z3dtRv6TxFm9U+
X-Gm-Gg: AYBFou3zcCrWFQUiin6vwelqnKpl9sMpWSqtD7nSafLzBS1zd9O60fdavRXGDHS0YyC
	sscw+pjQqnVzlMsf+fxinqGS9hcZC3efY4UaN4zP5enAg97gkzX7pQyQOigw86ttjVMlZay7Y44
	Yx6+igL4G2anf3fP2L0732r7LtfcIHuGo58JMGe7MiuHhxyuhjlNjKaJaSDvNb5e96fARAm8GkO
	6ZqeQPSHHsT2Sp+q0bI4eP7Q/n/LjG0RY4ImrNJ1PFJ+7QuJgr7GKlY1SS/C/VYzq35qs8oFTbB
	8obI0TFHEst2TuFzqiDbSuSYTwQzu7oTiJMVmjyjR+3Dqgz2Emvb/s5STmwDhNhee9FXJMNxEYO
	qiBl7826+kPf7hZ/dZ+sS
X-Received: by 2002:a17:903:440c:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2e301ae0dcbmr307005ad.9.1790789996691; Wed, 30 Sep 2026
 10:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com> <20260930-perf_fix_pylint_errors-v2-3-945cd526576b@arm.com>
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-3-945cd526576b@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Sep 2026 10:39:36 -0700
X-Gm-Features: AclHuK9kLeMrfwk9I-RYYoof2MH0Qg05_NtpTwJTjZx8s_pCEExP8FfQ-LN3U-8
Message-ID: <CAP-5=fVzy-=8ryObpHWiW6WDcvpW7SqRkAWwmNvoSgQmgz-3gQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf test: Suppress optparse deprecation warning
 with older pylint
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 6:11=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Python 3.13 reversed optparse's deprecation, and pylint 3.3.5 removed it
> from the deprecated-module list. Perf supports older pylint versions,
> so suppress the warning on this import and document the reason. Keep
> other deprecated-module diagnostics enabled.
>
> Link: https://docs.python.org/3.13/whatsnew/3.13.html#optparse
> Link: https://pylint.readthedocs.io/en/latest/whatsnew/3/3.3/index.html#w=
hat-s-new-in-pylint-3-3-5
> Fixes: 8a54784e708b ("perf build: Add pylint build tests")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/tests/shell/lib/attr.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/=
lib/attr.py
> index 7f3d5b64b00dd7de45baff4f7d9baff89e003147..523257bcf8e126cb662af5897=
27144bb26cff4d5 100644
> --- a/tools/perf/tests/shell/lib/attr.py
> +++ b/tools/perf/tests/shell/lib/attr.py
> @@ -4,7 +4,8 @@ import configparser
>  import os
>  import sys
>  import glob
> -import optparse
> +# Pylint before 3.3.5 still treats optparse as deprecated.
> +import optparse  # pylint: disable=3Ddeprecated-module

Thanks Leo! Could we just update to argparse here?
```
diff --git a/tools/perf/tests/shell/lib/attr.py
b/tools/perf/tests/shell/lib/attr.py
index 7f3d5b64b00d..68f06df9565a 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -4,7 +4,7 @@ import configparser
 import os
 import sys
 import glob
-import optparse
+import argparse
 import platform
 import tempfile
 import logging
@@ -426,29 +426,20 @@ def setup_log(verbose):
     ch.setFormatter(formatter)
     log.addHandler(ch)

-USAGE =3D '''%s [OPTIONS]
-  -d dir  # tests dir
-  -p path # perf binary
-  -t test # single test
-  -v      # verbose level
-''' % sys.argv[0]
-
 def main():
-    parser =3D optparse.OptionParser(usage=3DUSAGE)
-
-    parser.add_option("-t", "--test",
-                      action=3D"store", type=3D"string", dest=3D"test")
-    parser.add_option("-d", "--test-dir",
-                      action=3D"store", type=3D"string", dest=3D"test_dir"=
)
-    parser.add_option("-p", "--perf",
-                      action=3D"store", type=3D"string", dest=3D"perf")
-    parser.add_option("-v", "--verbose",
-                      default=3D0, action=3D"count", dest=3D"verbose")
-
-    options, args =3D parser.parse_args()
-    if args:
-        parser.error('FAILED wrong arguments %s' %  ' '.join(args))
-        return -1
+    parser =3D argparse.ArgumentParser()
+
+    parser.add_argument("-t", "--test",
+                        action=3D"store", dest=3D"test", help=3D"single te=
st")
+    parser.add_argument("-d", "--test-dir",
+                        action=3D"store", dest=3D"test_dir", help=3D"tests=
 dir")
+    parser.add_argument("-p", "--perf",
+                        action=3D"store", dest=3D"perf", help=3D"perf bina=
ry")
+    parser.add_argument("-v", "--verbose",
+                        default=3D0, action=3D"count", dest=3D"verbose",
+                        help=3D"verbose level")
+
+    options =3D parser.parse_args()

     setup_log(options.verbose)
```

Thanks,
Ian

>  import platform
>  import tempfile
>  import logging
>
> --
> 2.34.1
>
