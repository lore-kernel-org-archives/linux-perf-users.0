Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA43955C320
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790398; cv=pass; b=bxZMGfc/pyJVofSrFbEpILkn4G8fgOomJs0oWHK3sUbJdEp7xt/qVraPboMjqo0F8dWWD6M3skmPkVAKpqk0OATWAV1RwIaCYsYHlHZliEvYJeCyyO2K51/XKGaReFWq3qoQUi5/8sXP86EkkGXn3qaWSEzvi7fDtm/KtK9WPEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790398; c=relaxed/simple;
	bh=w0tICuoTa2+9t83PhN3/TCdqvSbLHcBiTxwpgG1m2wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXxWKxk8+DVhvTnGwvbzV57H6m1TrLYI/1Nr+MRcW84nUtiQM50ZN/E8800LaY38XsKE372eseIrkWAzEFlTPLn03j8PPBwYYgh2/FqUEJ4sY3+gRXnoAyqaHHA9ZfwZA8RS73sFgtb5htkdnrq7t3ZMeqoZ56lNIlP9qMRV5wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vl2j8dSo; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vl2j8dSo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b445a84fso7035ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 10:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790790396; cv=none;
        d=google.com; s=arc-20260327;
        b=qhfcVkfXpEORCzDlxdmU0xsPP2p4GBBFVuYi2Q1igZrMx1s9SrPYcT0tg3WRBUaBPM
         ILGSKJMXyNJ+aqThzR222hSXtGzAi/30ALxSISxCc0tGMzyxhKZ2YsHKC8Zq5yIoYICp
         1xk7dE1g/bbN6CYnSaQoL1cxf3qwaNlVx1MKyhMb4GQUBnJsXNy03z/0W9GDX5quIkR5
         0hFvWVGHP9fOck5xOtfVoo33iU+KITdiCq70v9lOjT0U2ICzQhOQXzz9aJwKTk8jtosE
         kay6zVl8PzctGjIS5Wm16UPInNu9mjUAqe76vs0GWCTEgyXLEOht8x07fdDqBI0mF2ma
         Tqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=owfGESY65vbCjIAUrqy6g/URvmlOMSe0YC9FIcjy/6A=;
        fh=9KdYkk6uiSzeROFbaRcpYu0uWqAs7YLV06eHccNjhE8=;
        b=E0xG6TngheFCH8FbfPZoddIBOQo7TDelHNwtwENd+LmYleEVnF4jE29KuqTE42teJT
         hkKO/lA1hKi5tMXX/vY1vTZKXtYpy4BljnG9GUaXLtjBq2VuYdsKnJKN3XxFsockqSFm
         aRP2A2HaMVNGlB0rYcV0i7t46lh6jtYRPk0mi1spVBUgZxWp95yQ9PZAo1Ft5ZhOEObT
         Dzm/PxKIzuGvhhKUBvsP0Qmg3CXwAMyUUBlSVf87sORkjVMeT+1oMgjwYFJGzWffNe+Y
         sim6yKxSaQl+1Z1WTB3rRfS0sBiX+Wd7T0vX0YDumMPURK7l+K2pk6dtbD7iOkyeTV8d
         XoFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790790396; x=1791395196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=owfGESY65vbCjIAUrqy6g/URvmlOMSe0YC9FIcjy/6A=;
        b=vl2j8dSoWT8FZQqYlYNTq4ID7QzjgUYE5KmHXAlBlnR/3mfq+ujvKgLsQt7PA9k6gE
         Fh186emZnYpzdZvxterExpx/yMtNYnEIlbegfH824yd5rCQF44wA330Gr0ee1lK3NRv+
         8w1nvoPgS38aBnn3kmNX9LYvq5Eu2rVIgWt8UQmrNa8Ss+XjLEJ5cvR/Op5LR3EXHBrH
         82WrRuFHhEciohoSuBurypNtw/OBquMFFSWHDJ5uljl3sT8olSJAi98l+J8e+xIEvsWe
         xz6Gji4xkXWbYZq4eewezXizsKsQamCk5bhh4QMHSahsOtNZhIFCxv9tXgvVn6nLKqo0
         LjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790790396; x=1791395196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owfGESY65vbCjIAUrqy6g/URvmlOMSe0YC9FIcjy/6A=;
        b=QcsCvtzFZdzTiOJ1tNou05rKRKkeZMNaDZAt9I9KFxYXOIlqKm40i6bLvgi//y1/vX
         semi12HM0erHDZlghf3/N3oOQPbLhBUJPzvo5u8Zy1QzYSdkHzvmHGpsZPDGRPe9R9Nj
         ATrq/1xAQWDoLLB/JECiwWdI/0Kkq8TVggFJgQjM+WCqpETYKkXPHBQfaPQHkB6zWWlJ
         zXsaJC2A7s8kFqZrvpt7qg0zzJ+8Ez5J2nyo76aTlInFLW3jMujwdnCLDGM+I/9lfpZ+
         TgVP2hoHH3K35MrRvmSYFhtYBP3MtXxIw7FirvM0WMzUl8Xto9NIM7+c0xeusGhlJAOQ
         mPdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTSgKmMlwIjSyI2GWn2MeH4rSR1b/rAMZtnDT6eE7nfroLf1308N4McUSTuFlAl5xFtHfk02+zmm1l9UY6DZr1@vger.kernel.org
X-Gm-Message-State: AFq9FYJWR243Ry3zHGx7gqe1ivO4KInfKSbIa5kzx0t5Clv8ay92K2kJ
	BIrDC37R6eFQo7tfkbg+h2XbsNCYLvaNj97aPmSiAosIQRMUaKvKdnJ2TYSLr/E7NZu+WZRlB1Q
	6tAYit7ah3wJiUfarmm4FSgVY0IgOjYCDGvwwW0AJ
X-Gm-Gg: AYBFou2/ncd78PeHqMGcsjI19bGcsWArhe9G2JtGVnUn3E5ciDCTFA+tH9fJs0VqUNM
	yilfaApmlWpeVu0PQtvikcQ+UFUZCzMdYunGT40ovuyI5hP7pjFr6UrvrYEkzScJaqJ2l6sGEdW
	Kd9KaZEKQnLvswSrkgePA9ohLtJ+KZY6Md5xqMPsrQN/f93U2iUSFDEUykuKNh8WkToyi0zFHfq
	qP+zX9W176UhaJx0+gNik36i27zcthu6wyfbQpqCaWEKvhLuOpu4i9Haw5lDriz0O4oEZlZo+gp
	c1DMP/KD9lP5xfUNIOkLRS0vPW+k06TaIdz+74s8qV7tPAI2FfptxV6Quccv/eygtNd6itxGobr
	oOz0yQHQVBw==
X-Received: by 2002:a17:903:40c5:b0:2df:9957:d1bd with SMTP id
 d9443c01a7336-2e2de7b2ba8mr4902705ad.18.1790790395316; Wed, 30 Sep 2026
 10:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com> <20260930-perf_fix_pylint_errors-v2-4-945cd526576b@arm.com>
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-4-945cd526576b@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Sep 2026 10:46:20 -0700
X-Gm-Features: AclHuK8a28BfpDM1TaVvVdEZDtDcaID83iikH9N8YTnc3Afd31SS0Gk0oIXvWO8
Message-ID: <CAP-5=fUyzOYv_f1apjXyOLRUzmCPTTk3yDXAOb=wUbukoENHNw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf python: Avoid shadowing exception name in
 PostgreSQL exporter
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 6:11=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> During the perf build, pylint reports:
>
>   ************* Module export-to-postgresql
>   python/export-to-postgresql.py:319:8: W0621: Redefining name 'e' from o=
uter scope (line 100) (redefined-outer-name)
>
> Rename 'e' to 'db_error' to clear the warning.
>
> Fixes: b1f968c9656a ("perf python: Port export-to-postgresql to perf modu=
le")
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/python/export-to-postgresql.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/python/export-to-postgresql.py b/tools/perf/pytho=
n/export-to-postgresql.py
> index b6782129354ed3b1bd750af41e7a002c7134bf12..9cac64dee361214de3d1f9907=
c5e6849327c8ed7 100755
> --- a/tools/perf/python/export-to-postgresql.py
> +++ b/tools/perf/python/export-to-postgresql.py
> @@ -316,9 +316,9 @@ class PostgresExporter:
>              # SQL identifiers are double-quoted; escape embedded double =
quotes by doubling them.
>              db_name =3D self.dbname.replace('"', '""')
>              self.do_query(f'CREATE DATABASE "{db_name}"')
> -        except Exception as e:
> +        except Exception as db_error:
>              shutil.rmtree(self.output_dir_name, ignore_errors=3DTrue)
> -            raise e
> +            raise db_error
>          self.disconnect()
>
>          self.connect(self.dbname)
>
> --
> 2.34.1
>
