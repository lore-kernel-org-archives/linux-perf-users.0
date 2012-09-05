From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH] perf: allow user to indicate path to objdump in command
 line
Date: Wed, 05 Sep 2012 15:11:51 -0600
Message-ID: <5047C017.5000707@gmail.com>
References: <1346754750.16299.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346754750.16299.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Maciek Borzecki <maciek.borzecki@gmail.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 9/4/12 4:32 AM, Maciek Borzecki wrote:
> When analyzing perf data from hosts of other architecture than one of the local
> host it's useful to call objdump that is part of a toolchain for that
> architecture. Instead of calling regular objdump, call one that user specified
> in command line.
>
> Signed-off-by: Maciek Borzecki <maciek.borzecki@gmail.com>


Acked-by: David Ahern <dsahern@gmail.com>
