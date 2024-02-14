Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8380128364
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935236; cv=none; b=LLlMAlzhGOxWUJSvUO4+sLZv1NbLwUb9MZfKV5rYc31iJvAZ0ytqsZ6E2hih+7BdRVZjVg4AIaFq8ZnTKAvPcP85EqWrrKVUbLpISbdmUJd0dL/xkIEt/eh8KSrgJwVExG7cHRqO1nX/DhWgJdgtlB8QVPATLzZdXIMix5dXpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935236; c=relaxed/simple;
	bh=RYolhRaSBk3tHHRJP2AKrWEV2HU0r7I18D51jWX8sVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+qEUyB986En48AiRRqhbe2bqEGEvJCmDzzoj8O6LwMhzgLXe2xXRSoYLgPKGSxONMJ3z5E3bRXgyFYMKEesLwPiUYjLfwWmcQdStWHYlWey6H4JXIRrfEM5sJOaF6jf6t7QJF3yky0x2L7PydkkXViLuZqYFXusJmsra1Be1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nX4j7pB4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nX4j7pB4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d89f0ab02bso4345ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707935234; x=1708540034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYolhRaSBk3tHHRJP2AKrWEV2HU0r7I18D51jWX8sVw=;
        b=nX4j7pB45nCzNODbm07O8edAGonfDxtwNdNq6eKvya56zrgKF2NC+nw4/Ue/60n/Yo
         blZ+S9uTY2VUyU6fAe+cVrXGZ9xw/v/XxWEnEY/O3+hYkvtoU8y2i6U21cd8KhCCgzff
         gr8VmY67nl7jaRxnhuDlxVg9TuEpyMw6IIhqbBQ3nnRskG7lZ6eI6wXmF476Q8dhhV/s
         OvEYCjUhIlPfEvkVfyetZMYIAn+iAZ0hVRpP3fJzbDTL0FTGbmwFUVV723TQwvL4U2kQ
         xD3726UObZpTh2vmN03QQRTnzEFd/Vnh4dzGB/HX9z8E2QEMYbxHWtQLIKL+Q6He/VHJ
         rChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707935234; x=1708540034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYolhRaSBk3tHHRJP2AKrWEV2HU0r7I18D51jWX8sVw=;
        b=xO8CzGMm0kSxkS9FkEflha/+eXfe29WMq3yGDKNagTm1gY9hiaZD+gjSi9YhZv4mes
         lJ5zAeJaNqAyKibotTJUNCnqIAV41TtIyY4ph0VA8ilWz7TfQC1mXXrCVXV41AU/1Qew
         rciibnrzvbSqTsgEX7CZdrC+4ziJeWmu+mvQtTzUYhPMW7xIODljpWXPlyRAHPKqwqo+
         T7NapFSwaVooCY4uFOXdthVAQJFLSZbew3tftdJ4+TNwIRdWmuGcV4HQD8vBFbsVr1/m
         8NCvICXEYy90QxNP+hGjdFm4orjFXU04g0jCXjVaUtmKpxdX2tUtgACClWkFRz9ZyKZl
         FsRg==
X-Forwarded-Encrypted: i=1; AJvYcCXu78fJ9PayiY0HiGSBpZWCw/dor67W4z4FbtfoyyHnz0yqMk4aN6JCgkhUfpwql8gNoyOCEnu6/tsHlzPK1+onVvLvE+znd46EGpiP/KOx3Q==
X-Gm-Message-State: AOJu0Yxcty3UZbzlWj9i6Tl9Prqh3DzTUkliMO94wd+ZZGxr/5y51ICY
	zZPOQp9iocMPzXcHFX0sbPKjkxuzYNp23sN6UtfVttNVkyyhT4WDSjSB1XDRY7Lf+4D+6YLFLz/
	W/0/DGJlBJIr4XxB2Ewkp1tQMkT3vAoE8CnPW
X-Google-Smtp-Source: AGHT+IH8XDo6YvH7aueWQbaHd9a/V2tiW4718i023Mu4JlaTHroOFQ7V/RKLuocdycIqnOHXeFPpZj7sl30PHMZgrwM=
X-Received: by 2002:a17:902:c385:b0:1db:7284:a766 with SMTP id
 g5-20020a170902c38500b001db7284a766mr54412plg.0.1707935233930; Wed, 14 Feb
 2024 10:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-3-irogers@google.com>
 <Zcz3iSt5k3_74O4J@x1>
In-Reply-To: <Zcz3iSt5k3_74O4J@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 10:27:02 -0800
Message-ID: <CAP-5=fV9Gd1Teak+EOcUSxe13KqSyfZyPNagK97GbLiOQRgGaw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] perf trace: Ignore thread hashing in summary
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:25=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Feb 13, 2024 at 10:37:04PM -0800, Ian Rogers wrote:
> > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > threads") made the iteration of thread tids unordered. The perf trace
> > --summary output sorts and prints each hash bucket, rather than all
> > threads globally. Change this behavior by turn all threads into a
> > list, sort the list by number of trace events then by tids, finally
> > print the list. This also allows the rbtree in threads to be not
> > accessed outside of machine.
>
> Can you please provide a refresh of the output that is changed by your pa=
tch?

Hmm.. looks like perf trace record has broken and doesn't produce
output in newer perfs. It works on 6.5 and so a bisect is necessary.

Without record it is hard to be repeatable but here is a before:
```
$ perf trace -a --summary sleep 1 2>&1 |grep events
Summary of events:
process1 (976898), 10 events, 0.1%
process2 (79368), 2 events, 0.0%
process3 (3759625), 11 events, 0.1%
...
```
Note, see how the events 10, 2, 11 aren't sorted.

After:
```
$ perf trace -a --summary sleep 1 2>&1 |grep events
Summary of events:
process1 (3190), 2 events, 0.0%
process1 (3191), 2 events, 0.0%
process2 (3681), 2 events, 0.0%
process3 (4034), 2 events, 0.0%
process3 (4035), 2 events, 0.0%
...
```
I've anonymized the process names.

Thanks,
Ian

> - Arnaldo
