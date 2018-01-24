From: =?UTF-8?Q?Ond=c5=99ej_Lyson=c4=9bk?= <olysonek@redhat.com>
Subject: Re: [PATCH] perf: add Python 3 support
Date: Wed, 24 Jan 2018 14:57:03 +0100
Message-ID: <ae57aa63-9142-fe73-1d94-1065c4dbe618@redhat.com>
References: <20180119205641.24242-1-jskarvad@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933642AbeAXN5G (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Jan 2018 08:57:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C29EB54146
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2018 13:57:06 +0000 (UTC)
In-Reply-To: <20180119205641.24242-1-jskarvad@redhat.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Jaroslav Skarvada <jskarvad@redhat.com>

Hi,

I tested the patch a bit and it seems to work fine. Some things I noticed:

>  	if (module == NULL ||
>  	    pyrf_event__setup_types() < 0 ||
> @@ -1221,7 +1273,11 @@ PyMODINIT_FUNC initperf(void)
>  	    pyrf_evsel__setup_types() < 0 ||
>  	    pyrf_thread_map__setup_types() < 0 ||
>  	    pyrf_cpu_map__setup_types() < 0)
> +#if PY_MAJOR_VERSION < 3
>  		return;
> +#else
> +		return module;
> +#endif

Wouldn't it make sense to clean up the partially loaded module
and return NULL if module != NULL, but the .*setup_types() fail?

There also seems to be a bug, even without Jaroslav's patch, where
e.g. event.prev_comm, event being a perf.sample_event, is _most
of the time_ a bytestring. I think it should be, and was intended to be,
a unicode string. I say most of the time, because if the string has the
right length, it will in fact be returned as a unicode string.

The problem can be reproduced with the script perf/python/tracepoint.py,
when run using python3. Most of the time, you will see something like
the following in the output:

prev_comm=bytearray(b'python3\x000\x00\x00\x00\x00\x00\x00\x00')

But if the length of prev_comm is just right, you'll get:
prev_comm=aaaaaaaaaaaaaaa

The problem is in perf/util/python.c:tracepoint_field(), calling
is_printable_array(data + offset, len). 'len' is the size of the whole
array where the string is stored, not of the string itself. It could be
resolved by passing the actual string length to is_printable_array()
somehow, or maybe with the following patch (it was not tested, and might
have unintended consequences):

diff --git a/tools/perf/util/print_binary.c b/tools/perf/util/print_binary.c
index 23e367063446..f124127ace3b 100644
--- a/tools/perf/util/print_binary.c
+++ b/tools/perf/util/print_binary.c
@@ -50,9 +50,13 @@ int is_printable_array(char *p, unsigned int len)

        len--;

-       for (i = 0; i < len; i++) {
+       for (i = 0; i < len && p[i] != 0; i++) {
                if (!isprint(p[i]) && !isspace(p[i]))
                        return 0;
        }
+       for (++i; i < len; ++i)  {
+               if (p[i] != 0)
+                       return 0;
+       }
        return 1;
 }
--

I'd prepare a proper patch myself, but unfortunatelly I don't have
the time right now and I'm not familiar with the codebase.

Best regards
Ondřej Lysoněk
