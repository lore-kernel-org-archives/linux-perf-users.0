From: sahil aggarwal <sahil.agg15@gmail.com>
Subject: Re: Sampling on sched:sched_switch
Date: Tue, 14 Apr 2015 11:12:11 +0530
Message-ID: <CAGAANTXY8UiP2yRUg5tVBB+PQdH8=X27MKUj=nSHvWHk-x5MJQ@mail.gmail.com>
References: <CAGAANTU3HMoZCNsN=PAWCb8Pqx89ZyO3aQcibXKN+ZxMx1MAOA@mail.gmail.com>
	<20150413151148.GI3200@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35190 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbDNFmN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Apr 2015 01:42:13 -0400
Received: by qkhg7 with SMTP id g7so222209457qkh.2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2015 22:42:12 -0700 (PDT)
In-Reply-To: <20150413151148.GI3200@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi Arnaldo

In my case:

bash-4.1# sudo perf stat -e sched:sched_switch sleep 1

 Performance counter stats for 'sleep 1':

                 0 sched:sched_switch

       1.004714901 seconds time elapsed


And  if i do:

bash-4.1# perf stat -e cs sleep 1

 Performance counter stats for 'sleep 1':

                 1 cs

       1.003306642 seconds time elapsed

To enable sampling on sched:sched_switch my perf_event_attr look like:

        e_open->attr.disabled           = 1;
        e_open->attr.type                  = PERF_TYPE_TRACEPOINT;
        e_open->attr.config               = 87;
        e_open->attr.size                  = sizeof(e_open->attr);
        e_open->attr.sample_period = 1;
        e_open->attr.inherit               = 1;
        e_open->attr.sample_type     = PERF_SAMPLE_TIME      |

PERF_SAMPLE_RAW       |

PERF_SAMPLE_CPU       |

PERF_SAMPLE_TID       ;
        e_open->attr.__reserved_1       = 0;
        e_open->attr.read_format        = 0;


Running in separate thread for each CPU:
perf_event_open(&e_open->attr,2552,0,-1,0)
perf_event_open(&e_open->attr,2552,1,-1,0)


But if do :

       e_open->attr.disabled           = 1;
        e_open->attr.type                  = PERF_TYPE_SOFTWARE;
        e_open->attr.config               = PERF_COUNT_SW_CONTEXT_SWITCHES;
        e_open->attr.size                  = sizeof(e_open->attr);
        e_open->attr.sample_period = 1;
        e_open->attr.inherit               = 1;
        e_open->attr.sample_type     = PERF_SAMPLE_TIME      |

PERF_SAMPLE_RAW       |

PERF_SAMPLE_CPU       |

PERF_SAMPLE_TID       ;
        e_open->attr.__reserved_1       = 0;
        e_open->attr.read_format          = 0;

It writes events to ring buffer but of course without any
args(prev_comm,prev_pid,next_comm,next_pid)

So i am not able to understand this difference. Why sched:sched_switch
doesnt give me any counter.
