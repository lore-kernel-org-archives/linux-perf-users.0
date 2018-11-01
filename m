From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 17/28] tools include uapi: Update asound.h copy
Date: Thu, 1 Nov 2018 20:54:45 +0900
Message-ID: <68477e3f-695f-b269-c44d-dbca4295ad05@sakamocchi.jp>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-18-acme@kernel.org> <s5hlg6ehwzk.wl-tiwai@suse.de>
 <97ff58b75de70d2b9dd8524f7899063d563a6a71.camel@perches.com>
 <20181031192951.GE6669@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031192951.GE6669@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Joe Perches <joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,

On Nov 1 2018 4:29, Arnaldo Carvalho de Melo wrote:
>> Wouldn't a symlink be simpler?
> 
> That would be equivalent to using it directly, see my response to
> Takashi for a few of the reasons this is done this way.

I have a plan to add changes to 'include/uapi/sound/asound.h' in a
development period for Linux kernel v4.21[1]. Would I need to add you to
C.C list of the future patch to notify the change, or things go well
without such special care for your side?

[1] 
https://github.com/takaswie/presentations/blob/master/20181021/contents.md


Regards

Takashi Sakamoto
