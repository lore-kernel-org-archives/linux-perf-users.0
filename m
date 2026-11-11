Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403595;
	b=I4nm7ZkJDPuquO1i70kNcTkpWHj56AyhJPUgmUqnAAMf3XxWNN+UmbqJb8twukE9k3cH
	 3998JZBvzzgPs8QXRbtEApH3xR42pc0A2IShe8Fno1NGHtTtJfdOgF72s14AzMFc4s/ck
	 1I06f3c3E5ivWiy/Ko2NnNNJPkDwckpw8zJNySjwliuY9g67YzOe8hAU1hYZ/A3aj+n8+
	 fwjbjPeXS/TbKSgNVxdURLvtLIIwHEtFtCaD2c8FVuWRCO3IPDWzqIXVkg1MTTv5nqJb3
	 a2z0RHHQaSalQJVFrF2D11IurK2gp/XSLqsXUkRFKL525CnnlWomkjvosKPqKSrCmqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ghtp+PE6LdUGDreRnJGGRi2XX8O7cwFG1jCnP2ts9Ws=;
	b=Uz7GMTB0TDhZ9YCMt7raEKLjvVX1hmqK9sfkRwUH2eArFpwaXOSl7EtpmA9NMZ9I+t2u
	 /UiRGZr290L7yV0GcmOLrjkiJMK2C2lCUgh7BATx6AtWLu+tF5txqjgHeEQWFA4qHXeK0
	 2ArPlBvEAWsPukGIBOlPVeImG8blnJVV78bbFgSjrMZZxhhOPaY7WxqT2t/fU/EZDRQX0
	 9rE1qDjqhms1FsaNDb13Zfpgq6/1zOgkUchrRYuu3d+D8cHMUlWlSHuQqrTMPpouswFeN
	 zI6j5ezw8e4sKGyhmGaynuIPSpGg9HnPUtJY3yQkbD0KmhGYF/e9vfE98xj3+TMtOKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X65SPKsB;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB7606A89D
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 13:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BCB7606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X65SPKsB
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2745001c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 05:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794403595; x=1795008395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghtp+PE6LdUGDreRnJGGRi2XX8O7cwFG1jCnP2ts9Ws=;
        b=X65SPKsBc6V/vkmkmUwzOgjwbhZ/Q2KndzScC4GzhEob6d2GbrKOZEFRZuoSEj60Np
         u6h5PqxC8gcFqo1HmTy1j9MZNYTDF7sFYeljC4hJofrUx0r9Fb0ieXabp6kYCJ4XW7yH
         XHpzBlkoQE1NkgJwnWXrRMUt0kERN0EFgnnMWHDCgiXw0CmIbiSnLGeva+4ZZ5vgHo7+
         YjO3nloPiMqyj6rWJbqQqGG8raBTJrftTZcY1eiU3+Wrm9janE+OkbhjVRQGhjNUkh86
         RuYlYewmsy5TkYbGhvCR8S2SsCNU4HWwivd/5AbusmzB9eTQ0esNsV5nIGKqqMqLRTW3
         UcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794403595; x=1795008395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ghtp+PE6LdUGDreRnJGGRi2XX8O7cwFG1jCnP2ts9Ws=;
        b=XgaDbjH8Q7vhT9phC02N5V5kcGayV18MVM/Vn9vhRcnQm5Ecer3+JcAa3o0lv+GVcT
         9Afmjv3X/FImk70IjyRFdNuacOv3w/fEdorOjVc5Q6EL9YMiGe9NXkrYAZ9JkfSnj8Zb
         K8L9kmrS+xTsUxDe1uX80HmfB9GzdzgpjvFBhtTFe9h+EzOVpY4Njt5j9GlauEZeUYZy
         VuvaDRjqDlJVuKeG5aHatz37M/zHtGzNkttSStYSwcAk8kJAbfUGhvlSF+KOw1CGuy5r
         LP+RUr+eFqpwkY8BEs61tjYKqo9JJUWkEU7MiB7Ta/zNTbuIUVYTHK37BvlNH7F1lsJu
         zQvw==
X-Gm-Message-State: APuU4Z9kx6eZ+fLHFHOmxNg8HuBhWtoVvDhQSkOGw4zfOAz/9VuB3ugP
	CjR1e7aluI8xNABf8TloUmPoQ4BryrvX+IHRYJLtj1YsXF7bhEGThjx8r6fbpGBt
X-Gm-Gg: AYBFou2tcuN97oUEF/kCmtrnMI3ytekPTYJDhQC2r7E8FxsVKkpZyOBa0utfbBO6X/p
	4ukbL1mDIVGZW5bZ8oFtYKS0vQKLIcjctQVzs8t+/JzJ7nPdAL4qP9hJfM/wEendLIUw8ixTvHs
	/V4aBVyjjQkTc9rYn63/76pvvEbaW2M8EG9GDzPl2DRJRg1pzuDoCRXTXEzkFeYw60aEneDAySg
	ZNoOTkJTvltlkz/kigSJoiMvf49v6/5k+3gNkqOdAaPK914JK1x6CwFjRw3ZJuhbD3nPTI8C4Nl
	LB2UQLpFZIqzjuD9aneAmahMc858DpDD2mFN8DbRMHfkarq6Z5Z1NpvCsfXOqlx/rmwxnNdxG1s
	InUDRmxtMs/kT4P/dG2mEk93bnIRKtIWT45a8/Zz4UWAWUF8NRifxrX4HKHzPelbglaBJuOyjjk
	jhLzOYG9dOXkcmBKmFEkkiC48/7bItPQO3rgX5YREWhFoYpP263tJ86DFfi7jHIP6jQeE1caHqk
	oVZ/8VwhqHCLOHK8b/hB67fkUYaSci109erTZa7xfOzNIzA293VjluCO862yYju/qFPbMygQ90s
	cSq7K1x1GAKsX720Vv75qduu+Pmb0O+57YlrmgRWZA==
X-Received: by 2002:a05:7022:107:b0:1af:2ba7:e44b with SMTP id a92af1059eb24-1b3c024be7cmr3097668c88.3.1794403594435;
        Wed, 11 Nov 2026 05:26:34 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc09sm33053502c88.10.2026.11.11.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:26:33 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v5 2/3] perf jevents: Make the model argument optional
Date: Wed, 11 Nov 2026 13:26:21 +0000
Message-ID: <20261111132622.2349165-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111132622.2349165-1-takano32@gmail.com>
References: <20261111041045.2031464-1-takano32@gmail.com>
 <20261111132622.2349165-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The model argument carries a default of "all", but a positional argument
with a default and no nargs is still required: "jevents.py x86 <dir>" exits
with "the following arguments are required: model", and so does any caller
that only wants the tables for an architecture.

Make it nargs='?' so the default is reachable and an omitted model means
"all".  Builds pass it explicitly, so the generated tables do not change.

Fixes: 5a09b1fd1b1f ("perf jevents: Add model list option")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v5: patch 3 says which keys a table may carry and checks the tree
    against that list, replacing the near-miss report that v4 had.
    The list is 51 names, 47 of which jevents.py reads; an architecture
    that is not there or is named as a path is an error (status 2)
    instead of a silent pass, and an object written without the list
    brackets is reported.  The name of a metricgroup is not treated as
    a key.  jsonschema is not used because perf's build would then
    require it, and the list holds the same names a schema would.
    The target is check-jevents, next to check-headers, and takes
    JEVENTS_CHECK_ARCH; a shell test covers a reported key, a clean
    tree and a missing architecture.

 tools/perf/pmu-events/jevents.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 61f778dcc1e5..f4dca47eb49b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1486,10 +1486,10 @@ def main() -> None:
 
   ap = argparse.ArgumentParser()
   ap.add_argument('arch', help='Architecture name like x86')
-  ap.add_argument('model', help='''Select a model such as skylake to
-reduce the code size.  Normally set to "all". For architectures like
-ARM64 with an implementor/model, the model must include the implementor
-such as "arm/cortex-a34".''',
+  ap.add_argument('model', nargs='?', help='''Select a model such as skylake to
+reduce the code size.  Normally set to "all", and that is what an omitted
+model means. For architectures like ARM64 with an implementor/model, the
+model must include the implementor such as "arm/cortex-a34".''',
                   default='all')
   ap.add_argument(
       'starting_dir',
-- 
2.53.0

